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

func die():
	velocity.x=0
	for child in get_children():
		if child is Area2D:
			var children=child.get_children()
			for c in children:
				c.queue_free()			
	change_animation('death')
	await animation.animation_finished
	set_process(false)
	set_physics_process(false)
