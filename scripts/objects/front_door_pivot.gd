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

		if is_open:
			_door_opened()


func _door_opened():
	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		return
		
	player.door_opened = true

	var objective_ui = player.get_node("Objective UI")
	var door_reached_text = objective_ui.get_node("Door Reached Text")

	door_reached_text.text = "..."
	door_reached_text.visible = true

	await get_tree().create_timer(2.0).timeout

	door_reached_text.text = "Hmmm... Something seems off... Go back to your bedroom."
	door_reached_text.visible = true


func get_interaction_text() -> String:
	if is_open:
		return "[E] Close"
	else:
		return "[E] Open"
