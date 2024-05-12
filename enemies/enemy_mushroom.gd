extends enemy
var direction:float
const SPEED = 80.0

func _physics_process(delta):
	run_towards_player(SPEED)
	
