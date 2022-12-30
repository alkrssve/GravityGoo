extends CanvasLayer


func _ready():
	load_hearts()
	load_coins()
	load_bullets()
	Global.hud = self

func load_hearts():
	$Life/HealthFull.rect_size.x = (Global.lives/2 * 14)
	if Global.lives % 2 == 0:
		$Life/HealthHalf.rect_size.x = 0
	if Global.lives % 2 == 1:
		$Life/HealthHalf.rect_size.x = 8
		
	$Life/HealthEmpty.rect_size.x = ((Global.max_lives - Global.lives)/2 * 14)
		
	$Life/HealthHalf.rect_position.x = $Life/HealthFull.rect_position.x + $Life/HealthFull.rect_size.x * $Life/HealthFull.rect_scale.x
	$Life/HealthEmpty.rect_position.x = $Life/HealthHalf.rect_position.x + $Life/HealthHalf.rect_size.x * $Life/HealthHalf.rect_scale.x

func load_bullets():
	$Bullets/AmmoFull.rect_size.x = Global.bullets * 13
		
	$Bullets/AmmoEmpty.rect_size.x = (Global.max_bullets - Global.bullets) * 13
		
	$Bullets/AmmoEmpty.rect_position.x = $Bullets/AmmoFull.rect_position.x + $Bullets/AmmoFull.rect_size.x * $Bullets/AmmoFull.rect_scale.x


func load_coins():
	$Money.text = String(Global.coins)
