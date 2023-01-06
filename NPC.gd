extends Area2D

export var sprite = ""
export var facing_right = false

func _ready():
	$AnimatedSprite.animation = sprite
	$AnimatedSprite.set_flip_h(facing_right)


func _on_NPC_area_entered(area):
	$E.visible = true


func _on_NPC_area_exited(area):
	$E.visible = false
