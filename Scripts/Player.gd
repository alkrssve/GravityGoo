extends KinematicBody2D

var MOVE_SPEED = 100
const JUMP_FORCE = 225
var GRAVITY = 15
const MAX_FALL_SPEED_UP = 300
const MAX_FALL_SPEED_DOWN = -300

onready var anim_player = $AnimationPlayer
onready var mouth_anim_player = $MouthAnimPlayer
onready var sprite = $Sprite
onready var mouth = $Mouth
onready var ammo_sprite = $Ammo
onready var timer = $Timer

var velocity = Vector2(0,0)
var y_velo = 0

var facing_right = false
var facing_up = false
var lift = true

func _ready():
	Global.player = self

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

	mouth.look_at(get_global_mouse_position())
	
	if Input.is_action_just_released("shoot"):
		play_mouth_anim("fire")
	
	var move_dir = 0
	var grounded = is_on_floor() || is_on_ceiling()
	if Input.is_action_pressed("right"):
		move_dir += 1
		velocity.x = 1
	elif Input.is_action_pressed("left"):
		move_dir -= 1
		velocity.x = -1
	
	if Input.is_action_just_released("flip_gravity"):
		if !facing_up:
			if grounded:
				y_velo = -20
				play_anim("blob")
				lift = false
				grounded = false
			GRAVITY = -10
		else:
			if grounded:
				y_velo = 20
				play_anim("blob")
				lift = false
				grounded = false
			GRAVITY = 10
			
	
	if Input.is_action_just_released("flip_gravity_up"):
		if grounded:
			y_velo = -20
			play_anim("blob")
			lift = false
			grounded = false
		GRAVITY = -10
	
	if Input.is_action_just_released("flip_gravity_down"):
		if grounded:
			y_velo = 20
			play_anim("blob")
			lift = false
			grounded = false
		GRAVITY = 10
	
	y_velo += GRAVITY
	
	if y_velo > MAX_FALL_SPEED_UP:
		y_velo = MAX_FALL_SPEED_UP
	if y_velo < MAX_FALL_SPEED_DOWN:
		y_velo = MAX_FALL_SPEED_DOWN
	
	move_and_slide(Vector2(velocity.x * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	velocity.x = lerp(velocity.x,0,0.5)
		
	if facing_right and move_dir > 0:
		flip_h()
	if !facing_right and move_dir < 0:
		flip_h()
	if facing_up and y_velo > 0 and lift:
		flip_v()
	if !facing_up and y_velo < 0 and lift:
		flip_v()
		
	if grounded:
		if move_dir == 0:
			if facing_up:
				play_anim("idle_flip")
			else:
				play_anim("idle")
		else:
			if facing_up:
				play_anim("move_flip")
			else:
				play_anim("move")
	else:
		if y_velo < 0 and lift:
			play_anim("float")
		elif y_velo > 0 and lift:
			play_anim("float")
		
func flip_h():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func flip_v():
	facing_up = !facing_up
	sprite.flip_v = !sprite.flip_v
	ammo_sprite.flip_v = !ammo_sprite.flip_v

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	
func play_mouth_anim(anim_name):
	if mouth_anim_player.is_playing() and mouth_anim_player.current_animation == anim_name:
		return
	mouth_anim_player.play(anim_name)


func _on_AnimationPlayer_animation_finished(anim_name = "blob"):
	lift = true
