extends enemy

var playerNearby:bool=false

func _process(_delta):
	if playerNearby:
		animation.play('fire')
	else:
		animation.play('no_fire')


func _on_detection_area_body_entered(_body):
	playerNearby=true


func _on_detection_area_body_exited(_body):
	playerNearby=false



