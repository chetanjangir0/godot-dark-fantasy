extends State
class_name Dash

@export var player:CharacterBody2D

const DASH_SPEED = 500.0
var dash_cooldown:float=0.8
var isDashing:bool=false

	
func Physics_update(_delta:float):
	if player.canDash and player.is_on_floor():
		isDashing=true
		get_tree().create_timer(0.2).timeout.connect(on_dash_timer_timeout)
		
		player.canDash=false
		get_tree().create_timer(dash_cooldown).timeout.connect(on_dash_cooldown)
		
		var dir=1
		if player.isFacingLeft:
			dir=-1
		if isDashing:
			player.change_animation('dash')
			player.velocity.x=dir*DASH_SPEED
	
	
	
	#handle transitions
	if not isDashing:
		if not player.is_on_floor() or (player.is_on_floor() and Input.is_action_just_pressed("jump")):
			player.velocity.x=0
			Transitioned.emit(self,"JumpFall")
		if player.is_on_floor():
			Transitioned.emit(self,'Idle')
			
	if Globals.player_health<=0:
		Transitioned.emit(self,'Death')
		
		


func on_dash_timer_timeout():
	isDashing=false

func on_dash_cooldown():
	player.canDash=true
