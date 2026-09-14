extends StaticBody3D

func get_interaction_text() -> String:
	return "[E] Read"
	
func interact():
	var player = get_tree().get_first_node_in_group("player")
	
	if player  == null:
		return
		
	var book_ui = player.get_node("Book UI")
	
	book_ui.visible = true
	
	player.can_move = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
