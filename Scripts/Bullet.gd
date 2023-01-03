extends KinematicBody2D

var GRAVITY = 5

var speed = 4
var movement = Vector2()
var y_velo = 0

onready var mouse_pos = null

var blood = preload("res://Blood.tscn")

func _ready():
	#if Global.facing_up:
	#	GRAVITY = -5
	#else:
	#	GRAVITY = 5
	mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - position).normalized()
	var new_angle = PI + atan2(direction.y, direction.x)
	rotation = new_angle
	movement = movement.move_toward(mouse_pos, delta)
	movement = movement.normalized() * speed
	#y_velo += GRAVITY
	#move_and_slide(Vector2(0, y_velo), movement)
	position = position + movement


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()
		
	if body.is_in_group("Ground"):
		for i in range(3):
			var blood_instance = blood.instance()
			get_tree().current_scene.add_child(blood_instance)
			blood_instance.global_position = global_position
			queue_free()
