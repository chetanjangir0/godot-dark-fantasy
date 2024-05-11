extends CharacterBody2D
class_name enemy
@onready var animation=$AnimationPlayer as AnimationPlayer
var overLap_damage=10
var hp=100
#hurt box and player enemy overlap detection box are same


func take_damage(damage):
	hp-=damage
	print(hp)

func enemy():
	pass

