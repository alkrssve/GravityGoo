extends Camera2D

export (NodePath) onready var player = get_node(player)

onready var actual_cam_pos := global_position

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$
