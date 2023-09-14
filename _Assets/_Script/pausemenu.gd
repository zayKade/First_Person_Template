extends Control
func _ready():
	$ColorRect.modulate.a8 = 120
func _input(event):
	if Input.is_key_pressed(KEY_ENTER) && get_tree().paused == true:
		get_tree().paused = false
		
	if Input.is_action_just_pressed("esc"):
		$mainMenuMusic.play()
		var tween = create_tween()
		tween.tween_property($Button, "position", Vector2(220, 220), 0.2)
		var text = create_tween()
		
		
		text.tween_property($Label, "position", Vector2(200, 100), 0.2)
		var tree  = get_tree()
		
		
		tree.paused = not tree.paused
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	if get_tree().paused == false:
		$mainMenuMusic.stop()
		var tween = create_tween()
		tween.tween_property($Button, "position", Vector2(120, 220), 0.2)
		
		
		var text = create_tween()
		text.tween_property($Label, "position", Vector2(200, 40), 0.2)
		
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
		hide()

func _on_button_pressed():
	get_tree().paused = false
	pass # Replace with function body.
