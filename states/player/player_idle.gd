extends State
class_name Idle

@export var animation: AnimationPlayer
@export var player:CharacterBody2D
func Enter():
	player.change_animation('idle')
	
	
	
func Physics_update(_dalta:float):
	
	
	
	
	#transitions
	if not player.is_on_floor() or (player.is_on_floor() and Input.is_action_just_pressed("jump")):
		Transitioned.emit(self,"JumpFall")
	if player.velocity.x!=0 or Input.get_axis('left','right'):
		Transitioned.emit(self,"Run")
	if Input.is_action_just_pressed('dash') and player.canDash:
		Transitioned.emit(self,'Dash')
	if Input.is_action_just_pressed('primary_action'):
		Transitioned.emit(self,'PrimaryAttack')
	if Input.is_action_just_pressed('secondary_action'):
		Transitioned.emit(self,'SecondaryAttack')
	if Globals.player_health<=0:
		Transitioned.emit(self,'Death')
		
