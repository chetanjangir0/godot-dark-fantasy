extends enemy
var direction:float
const follow_speed = 80.0

func _physics_process(delta):
	if not canAttack:
		follow_player(follow_speed)
	else:
		velocity.x=0
		attack()
	
	if not is_on_floor():
		fall()
	
	
	
	
	if velocity.x!=0:
		animation.play('run')
	else:
		if animation.current_animation!='attack':
			animation.play('idle')
		
	move_and_slide()
