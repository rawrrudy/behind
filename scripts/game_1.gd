extends Node3D

@onready var pattern_display = $"Game UI/Game Area/Pattern 1 Display"
@onready var shape_options = $"Game UI/Game Area/Shape Options"

func _ready():
	shape_options.visible = false
	
	await get_tree().create_timer(3.0).timeout
	
	pattern_display.visible = false
	shape_options.visible = true
