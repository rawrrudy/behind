extends Node3D

var is_open := false
var is_moving := false

var closed_rotation := 0.0
var open_rotation := deg_to_rad(-90.0)

@export var open_speed := 2.0


func interact():
	if is_moving:
		return

	is_open = not is_open
	is_moving = true


func _process(delta):
	if not is_moving:
		return

	var target_rotation := open_rotation if is_open else closed_rotation

	rotation.y = move_toward(
		rotation.y,
		target_rotation,
		open_speed * delta
	)

	if is_equal_approx(rotation.y, target_rotation):
		rotation.y = target_rotation
		is_moving = false
		
func get_interaction_text() -> String:
	if is_open:
		return "[E] Close"
	else:
		return "[E] Open"
