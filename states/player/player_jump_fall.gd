extends State
class_name JumpFall

@export var animation: AnimationPlayer
@export var player:CharacterBody2D

const JUMP_VELOCITY = -400.0
var jump_buffer:bool=false
var jump_buffer_timeout:float=0.2
var gravity = 20
const SPEED = 200.0

func Enter():
	if player.is_on_floor():
		jump()
	
func Update(_delta:float):
	pass
	
func Physics_update(_delta:float):
	if not player.is_on_floor():
		player.velocity.y += gravity
		if player.velocity.y<0:
			player.change_animation('jump')
		else:
			player.change_animation('fall')
			
		if Input.is_action_just_pressed("jump"):
			jump_buffer=true
			get_tree().create_timer(jump_buffer_timeout).timeout.connect(on_jump_buffer_timeout)
	
		#if left or right pressed while in the air
		var direction = Input.get_axis("left", "right")
		if direction:
			player.velocity.x=direction*SPEED
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, 10)
			
	if player.is_on_floor():
		if jump_buffer:
			jump()
	
	
	#handle transitions
	if Globals.player_health<=0:
		jump_buffer=false
	if player.is_on_floor() and not jump_buffer:
		Transitioned.emit(self,'Idle')
	if Input.is_action_just_pressed('primary_action'):
		Transitioned.emit(self,'PrimaryAttack')
	if Input.is_action_just_pressed('secondary_action'):
		Transitioned.emit(self,'SecondaryAttack')
	
	
	
			
func jump()->void:
	player.velocity.y = JUMP_VELOCITY
	
func on_jump_buffer_timeout()->void:
	jump_buffer=false
