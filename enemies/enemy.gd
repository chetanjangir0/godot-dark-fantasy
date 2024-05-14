extends CharacterBody2D
class_name enemy
@onready var animation=$AnimationPlayer as AnimationPlayer
@onready var hitBox:Area2D=$hitBox
@onready var hurtBox:Area2D=$hurtBox
@onready var sprite:Sprite2D=$Sprite2D
var overLap_damage=10
var hp=100
var gravity = 20
var playerAround=false
#hurt box and player enemy overlap detection box are same

var isFacingLeft:bool=false

func _process(delta):
	if velocity.x!=0:
		isFacingLeft=velocity.x<0
	hitBox.scale.x=-1 if isFacingLeft else 1
	hurtBox.scale.x=-1 if isFacingLeft else 1
	sprite.flip_h=isFacingLeft


func take_damage(damage):
	hp-=damage
	print(hp)

func enemy():
	pass

func follow_player(speed:float):
	if not playerAround:
		velocity.x=0
		return
	var dir=0
	dir=((Globals.player_pos-position).normalized()).x
	velocity.x=dir*speed


func fall():
	velocity.y += gravity

func _on_detection_area_body_entered(body):
	if body.has_method('player'):
		playerAround=true


func _on_detection_area_body_exited(body):
	if body.has_method('player'):
		playerAround=false

