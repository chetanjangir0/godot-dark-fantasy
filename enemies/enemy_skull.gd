extends enemy
const follow_speed:float=70.0

func _process(_delta):
	if playerAround:
		animation.play('fire')
	else:
		animation.play('no_fire')
		
func _physics_process(delta):
	follow_player(follow_speed)
	move_and_slide()
