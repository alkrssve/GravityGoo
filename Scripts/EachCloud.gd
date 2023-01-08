extends Sprite

func _ready():
	randomize()
	position.x = rand_range(-500,1500)
	position.y = rand_range(500,1500)

func _process(delta):
	if position.x > 1600:
		position.x = -500
	
