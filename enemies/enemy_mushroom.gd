extends enemy
var direction:float
const follow_speed = 80.0


func _process(delta):
	flipBody()

func _physics_process(delta):
	if not canAttack:
		if animation.current_animation=='attack':#even if player moves out of the attack area during attack the attack is still perforemed 
			await animation.animation_finished
		else:
			follow_player(follow_speed)
	else:
		velocity.x=0
		attack()
	
	if not is_on_floor():
		fall()
	
	
	
	
	if velocity.x!=0:
		change_animation('run')
	else:
		change_animation('idle')
		
	move_and_slide()
