extends StaticBody3D

func interact():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	if player.act != 1 or not player.can_sleep:
		var objective_ui =player.get_node("Objective UI")
		var temporary_message = objective_ui.get_node("No Sleep Text")
		
		temporary_message.text = "You cannot sleep now."
		temporary_message.visible = true
		
		await get_tree().create_timer(1.0).timeout
		
		temporary_message.visible = false
		return
		
	player.can_move = false
	await player.sleep_transition()
	
	var objective_ui = player.get_node("Objective UI")
	var door_reached_text = objective_ui.get_node("Door Reached Text")
	door_reached_text.visible = false
	
	var act_text = player.get_node("Wake Screen/Act Text")
	
	player.act = 2
	player.can_sleep = false
	
	act_text.text = "ACT: 2"
	act_text.visible = true
	
	await get_tree().create_timer(3.0).timeout
	act_text.visible = false
	
	var tv_static = get_tree().current_scene.get_node("Geometry/TV Cabinet/TV/TV Static")
	var tv_static_sound = get_tree().current_scene.get_node("Geometry/TV Cabinet/TV/Static Sound")
	
	tv_static.visible = true
	tv_static_sound.play()
	
	var objective_text = objective_ui.get_node("Objective Text")
	objective_text.text = "Investigate the noise."
	objective_text.visible = true
	
	await get_tree().create_timer(2.0).timeout
	
	player.black_screen.visible = false
	player.animation_player.play("Wake Up")
	
func get_interaction_text() -> String:
	return "[E] Sleep" 
