extends Area3D
var door_sequence_started := false

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name != "Player":
		return
		
	if door_sequence_started:
		return
		
	door_sequence_started = true

	var objective_ui = body.get_node("Objective UI")

	var objective_text = objective_ui.get_node("Objective Text")
	var door_reached_text = objective_ui.get_node("Door Reached Text")

	objective_text.visible = false
	door_reached_text.visible = true
	door_reached_text.text = "Open the front door."
