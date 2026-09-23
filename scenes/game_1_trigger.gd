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

	print("GAME 1 START")
