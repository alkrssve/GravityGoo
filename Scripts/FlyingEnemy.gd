extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 30
var GRAVITY = 1
var velocity = Vector2(0,0)
var up_direction = Vector2.UP

var facing_right = true

var dead = false

onready var particle = $Particles2D

func _physics_process(delta):
	get_direction()
	if $WallCheck.is_colliding():
		direction.y = -1
	velocity = calculate_velocity(direction,velocity,delta)
	move_and_slide(velocity)
	
	if facing_right and direction.x > 0:
		flip_h()
		$WallCheck.rotation = 180
	if !facing_right and direction.x < 0:
		flip_h()
		$WallCheck.rotation = 0


func flip_h():
	facing_right = !facing_right
	$Sprite.flip_h = !$Sprite.flip_h
	if !facing_right:
		particle.process_material.direction.x = 1 
		particle.position.x += 10
	else:
		particle.process_material.direction.x = -1
		particle.position.x += -10

func get_direction():
	#left
	if Global.player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x - 16 and Global.player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x - 200:
		direction.x = -1
	#right
	elif Global.player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x + 16 and Global.player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x + 200:
		direction.x = 1
	else:
		direction.x = 0
	#up
	if Global.player.get_node("CollisionShape2D").global_position.y < $CollisionShape2D.global_position.y - 16 and Global.player.get_node("CollisionShape2D").global_position.y > $CollisionShape2D.global_position.y - 200 and Global.player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x - 200:
		direction.y = -1
	#down
	elif Global.player.get_node("CollisionShape2D").global_position.y > $CollisionShape2D.global_position.y + 16 and Global.player.get_node("CollisionShape2D").global_position.y < $CollisionShape2D.global_position.y + 200 and Global.player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x + 200:
		direction.y = 1
	else:
		direction.y = 0

func calculate_velocity(dir, vel, delta):
	var new_vel = vel
	
	new_vel.y = dir.y * speed	
	new_vel.x = dir.x * speed
	
	if dead:
		new_vel = Vector2.ZERO
		
	return new_vel
		
