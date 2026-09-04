extends TextureRect

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	visible = false
	_flicker_loop()
	
func _flicker_loop():
	while true:
		await get_tree().create_timer(
			rng.randf_range(0.5, 3.0)
		).timeout
		
		var viewport_size := get_viewport_rect().size
		
		position.x = rng.randf_range(
			0.0,
			max(0.0, viewport_size.x - size.x)
		)
		
		position.y = rng.randf_range(
			0.0,
			max(0.0, viewport_size.y - size.y)
		)
		
		visible = true
		
		await get_tree().create_timer(
			rng.randf_range(0.25, 0.45)
		).timeout
		
		visible = false


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Apartment.tscn")
