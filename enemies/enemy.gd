extends CharacterBody2D
class_name enemy
@onready var animation=$AnimationPlayer as AnimationPlayer
var overLap_damage=10
var hp=100

var playerAround=false
#hurt box and player enemy overlap detection box are same


func take_damage(damage):
	hp-=damage
	print(hp)

func enemy():
	pass

func run_towards_player(speed:float):
	var dir=0
	if playerAround:
		dir=((Globals.player_pos-position).normalized()).x
	velocity.x=dir*speed
	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.has_method('player'):
		playerAround=true


func _on_detection_area_body_exited(body):
	if body.has_method('player'):
		playerAround=true

