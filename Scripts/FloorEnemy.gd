extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 50
var GRAVITY = 200
var velocity = Vector2(0,0)
var up_direction = Vector2.UP

var facing_right = true

onready var anim_player = $AnimationPlayer

var dead = false

func _ready():
	play_anim("Idle")
	
func _physics_process(delta):
	var grounded = is_on_floor()
	
	get_direction()
	velocity = calculate_velocity(direction,velocity,delta)
	move_and_slide(velocity,up_direction)
	if grounded:
		if direction.x == 0:
			play_anim("Idle")
		else:
			play_anim("Move")

	if facing_right and direction.x > 0:
		flip_h()
	if !facing_right and direction.x < 0:
		flip_h()
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	
func flip_h():
	facing_right = !facing_right
	$Sprite.flip_h = !$Sprite.flip_h

func get_direction():
	#left
	if Global.player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x - 16 and Global.player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x - 200:
		direction.x = -1
	#right
	elif Global.player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x + 16 and Global.player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x + 200:
		direction.x = 1
	else:
		direction.x = 0

func calculate_velocity(dir, vel, delta):
	var new_vel = vel
	
	if !is_on_floor():
		new_vel.y += GRAVITY * delta
		
	if is_on_floor():
		new_vel.x = dir.x * speed
	elif direction.x == 0:
		new_vel.x = 0
	
	if dead:
		new_vel = Vector2.ZERO
		
	return new_vel
		


func _on_HitDetection_body_entered(body):
	if body.is_in_group("PlayerBullet"):
		queue_free()
		body.queue_free()
