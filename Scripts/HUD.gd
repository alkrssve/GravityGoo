extends CanvasLayer

var zeroes = []

onready var anim_player = $Bullets/AmmoAnimationPlayer
onready var sprite = $Bullets/AmmoFull/AmmoSprite

func _ready():
	load_hearts()
	load_coins()
	load_bullets()
	Global.hud = self
	zeroes.resize(5)
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
	
	if Global.coins >= 100000:
		$Money.text = String(Global.coins)
	elif Global.coins >= 10000:
		$Money.text = "0" + String(Global.coins)
	elif Global.coins >= 1000:
		$Money.text = "00" + String(Global.coins)
	elif Global.coins >= 100:
		$Money.text = "000" + String(Global.coins)
	elif Global.coins >= 10:
		$Money.text = "0000" + String(Global.coins)
	elif Global.coins > 0:
		$Money.text = "00000" + String(Global.coins)
	else:
		$Money.text = "000000"
	
func load_keys():
	$Keys/KeyAmount.text = String(Global.keys)
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
