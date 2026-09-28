extends Node3D

var pattern := ["Square", "Triangle", "Circle"]
var current_index := 0
var round := 1

@onready var pattern_display = $"Game UI/Game Area/Pattern 1 Display"
@onready var shape_options = $"Game UI/Game Area/Shape Options"

func _ready():
	shape_options.visible = false
	
	var circle_shape = $"Game UI/Game Area/Shape Options/Circle/Polygon2D"
	_make_circle(circle_shape, 55.0)
	
	await get_tree().create_timer(3.0).timeout
	
	pattern_display.visible = false
	shape_options.visible = true


func _on_square_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if pattern[current_index] == "Square":
				current_index += 1
				
				if current_index >= pattern.size():
					round_complete()
					
				print("Correct: Square")
			else:
				print("Wrong")


func _on_triangle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if pattern[current_index] == "Triangle":
				current_index += 1
				
				if current_index >= pattern.size():
					round_complete()
					
				print("Correct: Triangle")
			else:
				print("Wrong")


func _on_circle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if pattern[current_index] == "Circle":
				current_index += 1
				
				if current_index >= pattern.size():
					round_complete()
					
				print("Correct: Circle")
			else:
				print("Wrong")


func _on_pentagon_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if pattern[current_index] == "Pentagon":
				current_index += 1
				
				if current_index >= pattern.size():
					round_complete()
					
				print("Correct: Pentagon")
			else:
				print("Wrong")
				

func _make_circle(polygon: Polygon2D, radius: float, points: int = 32):
	var circle_points := PackedVector2Array()
	
	for i in range(points):
		var angle := TAU * float(i) / float(points)
		circle_points.append(
			Vector2(cos(angle), sin(angle)) * radius
		)
		
	polygon.polygon = circle_points
	
func round_complete():
	print("Round", round, "Complete")
