
extends Area3D

var triggered := false


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name != "Player":
		return

	if triggered:
		return

	triggered = true
	body.can_move = false

	body.transitioning_to_game1 = true
	body.reparent(get_tree().root)

	var tree = get_tree()
	var game1_scene = preload("res://scenes/mini-games/game 1/game1.tscn")

	var error = tree.change_scene_to_packed(game1_scene)
	if error != OK:
		push_error("Failed to load Game 1. Error code: " + str(error))
		return

	await tree.scene_changed

	var game1 = tree.current_scene
	var game_world = game1.get_node("Game World")
	var spawn = game_world.get_node("Game 1 Spawn")

	body.reparent(game_world)
	body.global_transform = spawn.global_transform
	
	var old_wake_screen = body.get_node_or_null("Wake Screen")
	if old_wake_screen:
		old_wake_screen.visible = false

	body.game1_mode = true
	body.can_move = true

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
