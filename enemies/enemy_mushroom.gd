extends enemy
var direction:float
const follow_speed = 80.0

func _physics_process(delta):
	follow_player(follow_speed)
	
	if not is_on_floor():
		fall()
		
	move_and_slide()
