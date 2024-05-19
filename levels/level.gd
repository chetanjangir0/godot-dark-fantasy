extends Node2D
class_name parentLevel
@onready var camera = $Camera2D as Camera2D
	
func _process(_delta):
	camera.position.x=$player.global_position.x


