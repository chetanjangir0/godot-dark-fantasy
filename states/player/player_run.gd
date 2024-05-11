extends State
class_name Run

@export var player:CharacterBody2D
const SPEED = 200.0
	
func Physics_update(_delta:float):
	var direction = Input.get_axis("left", "right")
	if direction:
		#for running
		if player.is_on_floor():
			player.change_animation('run')
		player.velocity.x = direction * SPEED
				
	else:
		player.velocity.x = 0
	
	#handle transitions
	if not player.is_on_floor() or (player.is_on_floor() and Input.is_action_just_pressed("jump")):
		Transitioned.emit(self,"JumpFall")
	if player.is_on_floor() and abs(player.velocity.x)<1:
		Transitioned.emit(self,'Idle')
	if Input.is_action_just_pressed('dash') and player.canDash:
		Transitioned.emit(self,'Dash')
	if Input.is_action_just_pressed('primary_action'):
		Transitioned.emit(self,'PrimaryAttack')
	if Input.is_action_just_pressed('secondary_action'):
		Transitioned.emit(self,'SecondaryAttack')
	if Globals.player_health<=0:
		Transitioned.emit(self,'Death')
		
