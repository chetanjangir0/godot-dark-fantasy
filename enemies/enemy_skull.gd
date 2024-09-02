extends enemy
const follow_speed:float=70.0
func _process(_delta):
	flipBody(true)
	if playerAround:
		change_animation('fire')
	else:
		change_animation('no_fire')
	
		
func _physics_process(_delta):
	if animation.current_animation!='death':
		follow_player(follow_speed)
	move_and_slide()

