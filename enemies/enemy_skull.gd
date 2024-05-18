extends enemy
const follow_speed:float=70.0

func _process(delta):
	flipBody(true)
	if animation.current_animation!="death":
		if playerAround:
			animation.play('fire')
		else:
			animation.play('no_fire')
	
		
func _physics_process(delta):
	if animation.current_animation!='death':
		follow_player(follow_speed)
	move_and_slide()

func die():
	velocity.x=0
	animation.play('death')
	await animation.animation_finished
	set_physics_process(false)
	set_process(false)
	hitBox.queue_free()
	hurtBox.queue_free()
	attackArea.queue_free()
