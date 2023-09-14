extends Node3D
var isClicked : bool = false
func _input(event):
	if Input.is_action_just_pressed("press"):
		if isClicked == true:
			print("goof")
		
	

func _on_activator_body_entered(body):
	if body.is_in_group("player"):
		isClicked = true
		$Label.show()
	pass # Replace with function body.


func _on_activator_body_exited(body):
	isClicked = false
	$Label.hide()
	pass # Replace with function body.
