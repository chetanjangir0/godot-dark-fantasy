extends enemy
var direction:float
const follow_speed = 50.0


func _process(_delta):
	flipBody()

func _physics_process(_delta):
	if not canAttack:
		if animation.current_animation=='attack':#even if player moves out of the attack area during attack the attack is still perforemed 
			await animation.animation_finished
		else:
			follow_player(follow_speed)
	else:
		velocity.x=0
		attack()
	
	
	if animation.current_animation=='hit':
		velocity.x=0
	
	change_animation('idle')
	
	
	#some death logic
	if is_on_floor():
		change_animation('death')
		await animation.animation_finished
		for child in get_children():
			if child is Area2D:
				child.queue_free()
		set_process(false)
		set_physics_process(false)
		
	move_and_slide()
	
func die():
	if not is_on_floor():
		fall()
		change_animation('fall')
