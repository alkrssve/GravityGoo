extends Area2D


func _on_Shop_area_entered(area):
	$E.visible = true


func _on_Shop_area_exited(area):
	$E.visible = false
