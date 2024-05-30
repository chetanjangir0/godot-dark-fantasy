extends CharacterBody2D
class_name Player
@onready var orientMarker=$Marker2D as Marker2D
@onready var animation:AnimationPlayer=$AnimationPlayer
@export var attackCooldown:float=0.5
var anim_priority={'death':6,'primary_attack':5,'secondary_attack':5,'run':1,'jump':1,'idle':1,'fall':1,'dash':1}
var isFacingLeft:bool=false
var canDash:bool=true
var canAttack=true

func _physics_process(_delta):
	Globals.player_pos=global_position
	
	##set the flip orientation to the privious when the player stands after moving
	if velocity.x!=0:
		isFacingLeft=velocity.x<0
	orientMarker.scale.x=-1 if isFacingLeft else 1


func change_animation(new_anim:String)->void:
	if not animation or not animation.has_animation(new_anim):
		return
	if animation.current_animation and anim_priority[animation.current_animation] > anim_priority[new_anim]:
		await animation.animation_finished
	animation.play(new_anim)

func take_damage(damage):
	print('player is being hit')
	Globals.player_health-=damage
	print(Globals.player_health)


func _on_attack_cooldown():
	canAttack=true

func player():
	pass
	
