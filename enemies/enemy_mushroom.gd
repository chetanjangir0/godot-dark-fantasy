extends enemy
var direction:float
const follow_speed = 80.0

func _physics_process(delta):
	follow_player(follow_speed)
	
	if not is_on_floor():
		fall()
	
	if velocity.x!=0:
		animation.play('run')
	else:
		animation.play('idle')
		
	move_and_slide()
