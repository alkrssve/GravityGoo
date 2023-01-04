extends KinematicBody2D

var GRAVITY = 5

var velocity = Vector2(0,0)
var y_velo = 0

# Set the strength of the impulse
var impulse_strength = 100 * rand_range(1,5)

# Generate a random angle between 0 and 360 degrees
var angle = rand_range(0, 360)

# Calculate the x and y components of the impulse vector
var impulse_x = impulse_strength * cos(angle)
var impulse_y = impulse_strength * sin(angle)

onready var sprite = $Sprite

var blood_images = ["res://Sprites/Player/BloodSplatter/Blood_1.png","res://Sprites/Player/BloodSplatter/Blood_1.png",
					"res://Sprites/Player/BloodSplatter/Blood_1.png","res://Sprites/Player/BloodSplatter/Blood_1.png",
					"res://Sprites/Player/BloodSplatter/Blood_1.png","res://Sprites/Player/BloodSplatter/Blood_1.png"]

func _ready():
	sprite.texture = load(blood_images[rand_range(0,6)])

func _physics_process(delta):
	if impulse_y < 50: 
		impulse_y += GRAVITY
	else:
		impulse_x = impulse_x/2
	# Apply the impulse to the body
	move_and_slide(Vector2(impulse_x, impulse_y))
	
	if position.y > 300:
		queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Ground"):
		set_process(false)
		set_physics_process(false)
		set_process_input(false)
		set_process_internal(false)
		set_process_unhandled_input(false)
		set_process_unhandled_key_input(false)
	


func _on_Timer_timeout():
	queue_free()
