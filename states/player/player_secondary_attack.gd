extends State
class_name SecondaryAttack

@export var animation: AnimationPlayer
@export var player:CharacterBody2D

func Enter():
	if not player.canAttack:
		return
	player.canAttack=false
	player.get_tree().create_timer(player.attackCooldown).timeout.connect(player._on_attack_cooldown)
	player.change_animation('secondary_attack')
	
	
func Physics_update(_delta:float):

	
	#handle transitions
	if player.is_on_floor() and abs(player.velocity.x)<1:
		Transitioned.emit(self,'Idle')
	if not player.is_on_floor() or (player.is_on_floor() and Input.is_action_just_pressed("jump")):
		Transitioned.emit(self,"JumpFall")
	if player.velocity.x!=0 or Input.get_axis('left','right'):
		Transitioned.emit(self,"Run")
	if Globals.player_health<=0:
		Transitioned.emit(self,'Death')
	
	
		
