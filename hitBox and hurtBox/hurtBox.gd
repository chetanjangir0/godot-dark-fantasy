extends Area2D
class_name Hurtbox

var insideHitbox = false
@export var repeat = false
@export var damage_interval = 1.0 

var damage_timer = Timer.new()  
var current_hitbox:Hitbox

func _ready():
	#this part creates repeating timer
	add_child(damage_timer) 
	damage_timer.set_wait_time(damage_interval) 
	damage_timer.connect("timeout", _on_damage_timer_timeout)  

func _on_hurtBox_entered(hitbox):
	if not (hitbox is Hitbox):
		return
	insideHitbox = true
	current_hitbox=hitbox
	if owner.has_method('take_damage'):
		owner.take_damage(hitbox.damage)
		if repeat:
			damage_timer.start()  # Start the Timer when the Hurtbox enters the Hitbox

func _on_hurtBox_exited(area):
	insideHitbox = false
	damage_timer.stop()  # Stop the Timer when the Hurtbox exits the Hitbox

func _on_damage_timer_timeout():
	if insideHitbox and repeat:
		if owner.has_method('take_damage'):
			owner.take_damage(current_hitbox.damage)  # Apply damage when the Timer times out
