extends Area3D

var triggered := false

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.name != "Player":
		return
		
	if triggered:
		return
		
	var tv = get_tree().current_scene.get_node(
		"Geometry/TV Cabinet/TV/TV Interactable"
	)
	
	if not tv.feed_revealed:
		return
		
	triggered = true
	
	var jumpscare_screen = body.get_node(
		"Wake Screen/Jumpscare Screen"
	)
	
	jumpscare_screen.visible = true
	
	var ghost_image = jumpscare_screen.get_node("Ghost Image")
	ghost_image.visible = true
	
	var jumpscare_sound = get_tree().current_scene.get_node("Jumpscare Sound")
	jumpscare_sound.play()
	
	var spawn = get_tree().current_scene.get_node("Geometry/Game Room Spawn")
	
	body.global_position = spawn.global_position
	body.global_rotation = spawn.global_rotation
	
	await get_tree().create_timer(2.5).timeout
	
	ghost_image.visible = false
	jumpscare_screen.visible = false
	
	var black_screen = body.get_node("Wake Screen/Black Screen")
	var act_text = body.get_node("Wake Screen/Act Text")
	
	black_screen.visible = true
	black_screen.modulate.a = 1.0
	
	act_text.text = "ACT: 3"
	act_text.visible = true
	
	await get_tree().create_timer(3.0).timeout
	
	act_text.visible = false
	
	body.global_position = spawn.global_position
	body.global_rotation = spawn.global_rotation
	
	black_screen.visible = false
	
