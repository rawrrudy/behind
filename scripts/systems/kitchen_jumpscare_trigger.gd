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
