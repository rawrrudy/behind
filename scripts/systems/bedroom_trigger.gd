extends Area3D

@onready var bang_sound: AudioStreamPlayer = get_tree().current_scene.get_node("Bang Sound")

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
	bang_sound.play()
	body.can_sleep = true

	var objective_ui = body.get_node("Objective UI")
	var door_reached_text = objective_ui.get_node("Door Reached Text")
	
	await get_tree().create_timer(0.7).timeout
	door_reached_text.text = "."
	
	await get_tree().create_timer(0.7).timeout
	door_reached_text.text = ".."
	
	await get_tree().create_timer(0.7).timeout
	door_reached_text.text = "..."
	
	await get_tree().create_timer(2.5).timeout
	door_reached_text.text = "Must be a rat or something... Go back to sleep."
