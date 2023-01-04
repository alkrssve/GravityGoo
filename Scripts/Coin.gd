extends Area2D

export var coinType = 0
signal coin_collected

func _ready():
	if(coinType == 0):
		$AnimatedSprite.animation = "Coin1"
	if(coinType == 1):
		$AnimatedSprite.animation = "Coin2"
	if(coinType == 2):
		$AnimatedSprite.animation = "Coin3"
	if(coinType == 3):
		$AnimatedSprite.animation = "Diamond"
	if(coinType == 4):
		$AnimatedSprite.animation = "Key"
	if(coinType == 5):
		$AnimatedSprite.animation = "Ammo"
	

func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("coin_collected", coinType)
		queue_free()
