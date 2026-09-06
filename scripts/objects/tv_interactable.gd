extends StaticBody3D

var is_on := true

func interact():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	if not is_on:
		return

	is_on = false

	var tv_static = get_parent().get_node("TV Static")
	var tv_static_sound = get_parent().get_node("Static Sound")

	tv_static.visible = false
	tv_static_sound.stop()

	var objective_ui = player.get_node("Objective UI")
	var objective_text = objective_ui.get_node("Objective Text")

	objective_text.text = "Return to your bedroom."
	objective_text.visible = true

func get_interaction_text() -> String:
	if is_on:
		return "[E] Turn off"
	return ""
