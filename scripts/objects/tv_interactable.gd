extends StaticBody3D

var is_on := true
var feed_revealed := false
var second_event_ready := false


func _process(_delta):
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return

	var player = players[0]

	var ray = player.get_node("Head/InteractionRay")

	if is_on and not feed_revealed:
		if ray.is_colliding() and ray.get_collider() == self:
			var objective_ui = player.get_node("Objective UI")
			var objective_text = objective_ui.get_node("Objective Text")

			objective_text.text = "Was the television turned on before... Turn it off."
			objective_text.visible = true


	if not second_event_ready and not feed_revealed:
		if ray.is_colliding() and ray.get_collider() == self:
			reveal_feed(player)


func interact():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	if is_on and not feed_revealed:
		is_on = false

		var tv_static = get_parent().get_node("TV Static")
		var tv_static_sound = get_parent().get_node("Static Sound")

		tv_static.visible = false
		tv_static_sound.stop()

		var objective_ui = player.get_node("Objective UI")
		var objective_text = objective_ui.get_node("Objective Text")

		objective_text.text = "Return to your bedroom."
		objective_text.visible = true


func reveal_feed(player):
	if feed_revealed:
		return

	feed_revealed = true

	var tv_static = get_parent().get_node("TV Static")
	var tv_static_sound = get_parent().get_node("Static Sound")
	var tv_feed_screen = get_parent().get_node("TV Feed Screen")

	tv_static.visible = false
	tv_static_sound.stop()

	tv_feed_screen.visible = true

	var objective_ui = player.get_node("Objective UI")
	var objective_text = objective_ui.get_node("Objective Text")

	await get_tree().create_timer(0.7).timeout
	objective_text.text = "."

	await get_tree().create_timer(0.7).timeout
	objective_text.text = ".."

	await get_tree().create_timer(0.7).timeout
	objective_text.text = "..?"

	await get_tree().create_timer(2.5).timeout
	objective_text.text = "GO TO THE KITCHEN AND HIDE IMMEDIATELY."
	objective_text.visible = true


func get_interaction_text() -> String:

	if is_on and not feed_revealed:
		return "[E] Turn off"

	return ""
	
func arm_second_event():
	second_event_ready = true
	is_on = true
