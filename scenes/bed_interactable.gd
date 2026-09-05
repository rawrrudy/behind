extends StaticBody3D

func interact():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	player.can_move = false
	await player.sleep_transition()
	
	var act_text = player.get_node("Wake Screen/Act Text")
	act_text.text = "ACT: 2"
	act_text.visible = true
	
	await get_tree().create_timer(3.0).timeout
	act_text.visible = false
	
func get_interaction_text() -> String:
	return "[E] Sleep" 
