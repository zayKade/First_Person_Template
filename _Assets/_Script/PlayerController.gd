extends CharacterBody3D
@export var SPEED : float = 5.0
@export var JUMP_VELOCITY : float = 4.5
@export var fallVELO : int = 9
@export var crouchingSpeed : float = 2.1
const ColliderHEIGHT: float = 2.1
const MINHeight : float = 1.5
const MAXHeight : float = 2
@export var sprintSPEED : float = 1.9
var isCrouching : bool = false
var isSprinting : bool = false
@export var sense : float = 0.1
@onready var cam : Camera3D = $pivot/eyes
@onready var RayCast : RayCast3D = $pivot/hand
@onready var BOD : CollisionShape3D = $colider
@onready var Headcollison : RayCast3D = $"pivot/Headcollison checker"

#i put alot of stuff in funcs as the base template was clutterd
#I did not use the base games gravity as it felt too floaty
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity");

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	pass;

func _unhandled_input(event):
	#mouse look
	mouse_motion(event)
	#run code
	if Input.is_action_pressed('run') && isCrouching == false && is_on_floor():
		isSprinting = true
	else:
		isSprinting = false
	
func _physics_process(delta):
	#crouch code
	BOD.shape.height = clamp(BOD.shape.height,MINHeight,MAXHeight)
	if Input.is_action_pressed("crouch") && is_on_floor():
		crouch(delta)
	elif Headcollison.is_colliding()  && isCrouching && is_on_floor():
		crouch(delta)
	else:
		BOD.shape.height = lerp(BOD.shape.height,MAXHeight * 2,delta)
		isCrouching = false
	#adds gravity
	gravtiy(delta)
	
	# Handle Jump.
	jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	if isCrouching:
		velocity.x = direction.x * crouchingSpeed 
		velocity.z = direction.z * crouchingSpeed
	if isSprinting:
		velocity.x = direction.x * SPEED * sprintSPEED
		velocity.z = direction.z * SPEED * sprintSPEED
	if isSprinting == false && isCrouching == false:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	move_and_slide()

	return
	

func crouch(delta):
	BOD.shape.height -= ColliderHEIGHT * delta
	isCrouching = true

func gravtiy(delta):
	if not is_on_floor():
		velocity.y -= delta * fallVELO
	return

func jump():
	if Input.is_action_just_pressed("jump") && is_on_floor() && isCrouching == false:
		velocity.y = JUMP_VELOCITY
	return

func mouse_motion(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x  * sense));
		cam.rotate_x(deg_to_rad(-event.relative.y  * sense));
		cam.rotation.x = clamp(cam.rotation.x , deg_to_rad(-96), deg_to_rad(50));
		return;
	


