extends CharacterBody2D
class_name enemy
@onready var animation=$AnimationPlayer as AnimationPlayer
@onready var hitBox:Area2D=$hitBox
@onready var hurtBox:Area2D=$hurtBox
@onready var attackArea:Area2D=$attackArea
@onready var sprite:Sprite2D=$Sprite2D
@export var attackCooldown:float=2.0
var gravity = 20
var playerAround=false
var canAttack=false
var attackRecharged=true
#hurt box and player enemy overlap detection box are same
@export var hp=100:
	set(value):
		hp=value
		if hp<=0:
			die()

var isFacingLeft:bool=false

func _process(delta):
	if velocity.x!=0:
		isFacingLeft=velocity.x<0
	if isFacingLeft:
		hitBox.scale.x=-1
		hurtBox.scale.x=-1
		attackArea.scale.x=-1
		sprite.flip_h=true
	else:
		hitBox.scale.x=1
		hurtBox.scale.x=1
		attackArea.scale.x=1
		sprite.flip_h=false
		
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


func attack():
	if not attackRecharged:
		return
	attackRecharged=false
	animation.play('attack')
	get_tree().create_timer(attackCooldown).timeout.connect(_on_attack_cooldown)
	
func _on_attack_cooldown():
	attackRecharged=true

func fall():
	velocity.y += gravity
	
func die():
	set_physics_process(false)
	set_process(false)
	hitBox.queue_free()
	hurtBox.queue_free()
	attackArea.queue_free()
	animation.play('death')
	
	
	


func _on_detection_area_body_entered(body):
	if body.has_method('player'):
		playerAround=true


func _on_detection_area_body_exited(body):
	if body.has_method('player'):
		playerAround=false



func _on_attack_area_body_entered(body):
	if body.has_method('player'):
		canAttack=true


func _on_attack_area_body_exited(body):
	if body.has_method('player'):
		canAttack=false
