extends Area2D



func _on_player_entered(body):
	if body.has_method('player'):
		var current_scene = int(str(get_tree().current_scene.name))
		var next_level='res://usable levels/level_' + str(current_scene+1) + '.tscn'
		if ResourceLoader.exists(next_level):
			get_tree().change_scene_to_file(next_level)
		else:
			print('main menu')
		
