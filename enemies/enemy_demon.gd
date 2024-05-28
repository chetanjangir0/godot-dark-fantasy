extends enemy
var direction:float
const follow_speed = 50.0


func _process(_delta):
	flipBody(true)

func _physics_process(_delta):
	if not canAttack:
		if animation.current_animation=='attack':#even if player moves out of the attack area during attack the attack is still perforemed 
			await animation.animation_finished
		else:
			follow_player(follow_speed)
	else:
		velocity.x=0
		attack()
	
	change_animation('idle')
		
	move_and_slide()
