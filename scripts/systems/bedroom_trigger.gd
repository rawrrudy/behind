extends Area3D
var bedroom_sequence_started := false

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name != "Player":
		return
		
	if not body.door_opened:
		return
		
	if bedroom_sequence_started:
		return
	
	bedroom_sequence_started = true

	var objective_ui = body.get_node("Objective UI")
	var door_reached_text = objective_ui.get_node("Door Reached Text")

	door_reached_text.text = "..."
