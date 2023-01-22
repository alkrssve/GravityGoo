extends Area2D

onready var anim_player = $AnimationPlayer

var in_range = false

func _process(delta):
	if Input.is_action_just_pressed("interact") and in_range:
		Global.lives = Global.max_lives
		Global.hud.load_hearts()
		Global.last_save_x = global_position.x
		Global.last_save_y = global_position.y
		play_anim("Save")
	if Global.last_save_x != global_position.x:
		play_anim("NotSave")

func _on_SaveStatue_area_entered(area):
	in_range = true
	$E.visible = true


func _on_SaveStatue_area_exited(area):
	in_range = false
	$E.visible = false
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
