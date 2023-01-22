extends KinematicBody2D

var GRAVITY = 5

var speed = 200
var movement = Vector2()
var velocity = Vector2(0,0)
var angle

onready var mouse_pos = null

var blood = preload("res://Blood.tscn")

func _ready():
	angle = get_angle_to(Global.player_position)

func _physics_process(delta):
	velocity.x = cos(angle)
	velocity.y = sin(angle)
	global_position += velocity * speed * delta


func _on_Area2D_body_entered(body):
	if body.is_in_group("Ground"):
		queue_free()
	if body.is_in_group("Player"):
		body.damage(position.x)
		queue_free()
