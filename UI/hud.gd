extends CanvasLayer
@onready var health_bar:TextureProgressBar=$MarginContainer/TextureProgressBar

func _ready():
	Globals.connect('player_health_change',update_health_bar)
	
	
	



func update_health_bar():
	health_bar.value=Globals.player_health
	
