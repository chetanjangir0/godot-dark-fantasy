extends enemy

var direction: float
const follow_speed = 80.0
var walk_dir = -1
var walk_speed = 30

var is_walking = false
@export var idle_time = 2.0 # time to stay idle
@export var walk_time = 3.0 # time to walk

var timer = 0.0

func _ready():
	set_idle()

func _process(_delta):
	flipBody(true)

func _physics_process(_delta):
	# Check if the player is around first
	if playerAround:
		is_walking = false
		follow_player(follow_speed)
		change_animation('run')
		# Reset the timer to resume normal behavior after losing the player
		timer = 0.5  # small delay before resuming idle/walk
	else:
		# Handle the timer for idle/walking states
		timer -= _delta
		if timer <= 0.0:
			if is_walking:
				set_idle()
			else:
				set_walk()
		
		if is_walking:
			walk(walk_dir, walk_speed)
		
	if not is_on_floor():
		fall()

	move_and_slide()

func set_idle():
	is_walking = false
	timer = idle_time
	velocity.x = 0 # stop moving during idle
	change_animation('idle')

func set_walk():
	is_walking = true
	timer = walk_time
	walk_dir = -walk_dir # change direction after each walk period
	change_animation('walk')

func walk(dir, speed):
	velocity.x = dir * speed

