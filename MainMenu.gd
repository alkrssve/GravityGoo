extends Control
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func _on_Play_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	pass # Replace with function body.
