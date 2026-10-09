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

	var black_screen = body.get_node("Wake Screen/Black Screen")
	var act_text = body.get_node("Wake Screen/Act Text")

	black_screen.visible = true
	black_screen.modulate.a = 1.0

	act_text.text = "GAME 1: MATCH THE PATTERN"
	act_text.visible = true

	await get_tree().create_timer(3.0).timeout

	act_text.visible = false
	
	body.transitioning_to_game1 = true
	
	var game1_scene = preload("res://scenes/mini-games/game 1/game1.tscn")
	
	body.reparent(get_tree().root)
	
	var tree = get_tree()
	tree.change_scene_to_packed(game1_scene)
	await tree.scene_changed
	
	var game_world = get_tree().current_scene.get_node("Game World")
	var spawn = game_world.get_node("Game 1 Spawn")
	
	body.reparent(game_world)
	body.remove_child(body.get_node("Wake Screen"))
	body.global_transform = spawn.global_transform
	body.global_rotation = spawn.global_rotation
	
	body.game1_mode = true
	body.can_move = true
	
	var wake_screen = body.get_node("Wake Screen")
	wake_screen.visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
