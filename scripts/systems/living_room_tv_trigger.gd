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
	
	if tv.is_on:
		return
		
	triggered = true
	tv.arm_second_event()
	
	var tv_static = get_tree().current_scene.get_node(
		"Geometry/TV Cabinet/TV/TV Static"
	)
	var tv_static_sound = get_tree().current_scene.get_node(
		"Geometry/TV Cabinet/TV/Static Sound"
	)
	
	tv_static.visible = true
	tv_static_sound.play()
	
	var objective_ui = body.get_node("Objective UI")
	var objective_text = objective_ui.get_node("Objective Text")
	
	await get_tree().create_timer(0.7).timeout
	objective_text.text = "."
	
	await get_tree().create_timer(0.7).timeout
	objective_text.text = ".."
	
	await get_tree().create_timer(0.7).timeout
	objective_text.text = "..."
	
	await get_tree().create_timer(2.5).timeout
	objective_text.text = "Who turned it on again? Turn it Off."
	objective_text.visible = true
