extends CanvasLayer

var zeroes = []

onready var anim_player = $Bullets/AmmoAnimationPlayer
onready var sprite = $Bullets/AmmoFull/AmmoSprite

func _ready():
	load_hearts()
	load_coins()
	load_bullets()
	Global.hud = self
	zeroes.resize(8)
	zeroes.fill(0)


func load_hearts():
	$Life/HealthFull.rect_size.x = (Global.lives/2 * 17)
	if Global.lives % 2 == 0:
		$Life/HealthHalf.rect_size.x = 0
	if Global.lives % 2 == 1:
		$Life/HealthHalf.rect_size.x = 17
		
	$Life/HealthEmpty.rect_size.x = ((Global.max_lives - Global.lives)/2 * 17)
		
	$Life/HealthHalf.rect_position.x = $Life/HealthFull.rect_position.x + $Life/HealthFull.rect_size.x * $Life/HealthFull.rect_scale.x
	$Life/HealthEmpty.rect_position.x = $Life/HealthHalf.rect_position.x + $Life/HealthHalf.rect_size.x * $Life/HealthHalf.rect_scale.x

func load_bullets():
	$Bullets/AmmoFull.rect_size.x = Global.bullets * 15
	
	$Bullets/AmmoEmpty.rect_size.x = (Global.max_bullets - Global.bullets) * 15
		
	$Bullets/AmmoEmpty.rect_position.x = $Bullets/AmmoFull.rect_position.x + $Bullets/AmmoFull.rect_size.x * $Bullets/AmmoFull.rect_scale.x
	sprite.position.x = $Bullets/AmmoEmpty.rect_position.x - 10
	sprite.position.y = $Bullets/AmmoEmpty.rect_position.y + 4
	play_anim("shoot")
	if Global.bullets == 4:
		sprite.position.x = -50
	
func load_coins():
	$Money.text = String(Global.coins)
	#if String(Global.coins).length() < zeroes.size():
	#	var temp_zeroes = ""
	#	for i in range(0, zeroes.size() - String(Global.coins).length()):
	#		temp_zeroes += String(zeroes[i])
	#	$Money.text = temp_zeroes + String(Global.coins)
	
func load_keys():
	$Keys/KeyAmount.text = String(Global.keys)
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
