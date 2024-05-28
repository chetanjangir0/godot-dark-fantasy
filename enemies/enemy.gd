extends CharacterBody2D
class_name enemy
@onready var animation=$AnimationPlayer as AnimationPlayer
@onready var hitBox:Area2D=$hitBox
@onready var hurtBox:Area2D=$hurtBox
@onready var attackArea:Area2D=$attackArea
@onready var detectionArea:Area2D=$detectionArea
@onready var sprite:Sprite2D=$Sprite2D
@export var attackCooldown:float=2.0
@export var gravity = 20
var playerAround=false
var canAttack=false
var attackRecharged=true
var anim_priority={'death':10,'fall':10,'hit':8,'attack':5,'run':1,'idle':1,'walk':1,'fire':1,'no_fire':1}
#hurt box and player enemy overlap detection box are same
@export var hp=100:
	set(value):
		hp=value
		if hp<=0:
			die()

var isFacingLeft:bool=false:
	set(val):
		isFacingLeft=val
		scale.x=-1*scale.x
		
func take_damage(damage):
	hp-=damage
	change_animation('hit')
	print(hp)


func flipBody(opposite=false):
	if velocity.x!=0:
		var facing_left =!(velocity.x < 0) if opposite else velocity.x < 0
		if facing_left!=isFacingLeft:
			isFacingLeft=facing_left

func enemy():
	pass

func follow_player(speed:float):
	if not playerAround or hp<=0:
		velocity.x=0
		return
	var dir=0
	dir=((Globals.player_pos-position).normalized()).x
	velocity.x=dir*speed


func attack():
	if not attackRecharged:
		return
	attackRecharged=false
	change_animation('attack')
	get_tree().create_timer(attackCooldown).timeout.connect(_on_attack_cooldown)
	
func _on_attack_cooldown():
	attackRecharged=true

func fall():
	velocity.y += gravity
	
func die():
	change_animation('death')
	await animation.animation_finished
	set_physics_process(false)
	set_process(false)
	for child in get_children():
		if child is Area2D:
			child.queue_free()
	

	
	

func change_animation(new_anim:String)->void:
	if not animation or not animation.has_animation(new_anim):
		return
	if animation.current_animation and anim_priority[animation.current_animation] > anim_priority[new_anim]:
		return
	animation.play(new_anim)	


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
