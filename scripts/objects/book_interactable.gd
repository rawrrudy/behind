extends StaticBody3D

var book_open := false
var book_busy := false


func get_interaction_text() -> String:
	if book_open:
		return "[E] Close"
	return "[E] Read"


func interact():
	if book_busy:
		return

	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		return

	var book_ui = player.get_node("Book UI")
	var book_animation = book_ui.get_node("Book Animation")

	book_busy = true

	if not book_open:
		book_open = true

		book_ui.visible = true
		player.can_move = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		book_animation.play("Book_Open")
		await book_animation.animation_finished

	else:
		book_animation.play("Book_Close")
		await book_animation.animation_finished

		book_ui.visible = false
		player.can_move = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		book_open = false

	book_busy = false
