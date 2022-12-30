extends Node

var max_lives = 6
var lives = max_lives
var max_bullets = 4
var bullets = max_bullets
var coins = 100000
var position_lost = false
var item1_price = "10"
var item2_price = "10"
var save_num = 1
var last_save_x = 0
var last_save_y = 0

var jump_positions = []

var canTalk = false
var talkOver = false

var scn
var hud
var shop
var player

func lose_life():
	lives -= 1
	hud.load_hearts()
	if lives <= 0:
		position_lost = true
		player.save_position(last_save_x,last_save_y)
		lives = max_lives
		hud.load_hearts()
		
func lose_bullet():
	bullets -= 1
	hud.load_bullets()
	
func collect_money(coinType):
	if (coinType == 0):
		coins += 1
	if (coinType == 1):
		coins += 5
	if (coinType == 2):
		coins += 10
	hud.load_coins()
	
func set_save_position(x,y):
	last_save_x = x
	last_save_y = y

	
