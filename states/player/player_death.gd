extends State
class_name Death

@export var player:CharacterBody2D

func Enter():
	player.change_animation('death')
	player.velocity=Vector2.ZERO
func Exit():
	pass

func Update(_delta:float):
	pass
func Physics_update(_dalta:float):
	pass
