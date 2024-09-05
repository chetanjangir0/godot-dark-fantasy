extends Control


func _on_retry_pressed():
	Globals.player_health=100
	get_tree().change_scene_to_file("res://usable levels/level_1.tscn")


func _on_menu_pressed():
	Globals.player_health=100
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
