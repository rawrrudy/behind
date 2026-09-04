extends CharacterBody3D
var door_opened := false

@export var speed := 3.5
@export var mouse_sensitivity := 0.002

@onready var head: Node3D = $Head

const GRAVITY := 9.8


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Look left/right
		rotate_y(-event.relative.x * mouse_sensitivity)

		# Look up/down
		head.rotate_x(-event.relative.y * mouse_sensitivity)

		# Prevent the camera from flipping upside down
		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-89),
			deg_to_rad(89)
		)

	# Press ESC to release the mouse
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event.is_action_pressed("interact"):
		_interact()


func _physics_process(delta):
	_update_interaction_prompt()
	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# WASD input
	var input := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)

	# Convert keyboard input into world movement
	var direction := (
		transform.basis *
		Vector3(input.x, 0, input.y)
	).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
func _interact():
	var ray := $Head/InteractionRay

	if ray.is_colliding():
		var object = ray.get_collider()

		if object.has_method("interact"):
			object.interact()
		elif object.get_parent().has_method("interact"):
			object.get_parent().interact()
			
func _update_interaction_prompt():
	var ray := $Head/InteractionRay
	var prompt := $"Interaction UI"/"Prompt Container"/"Interaction Prompt"
	
	prompt.visible = false
	
	if not ray.is_colliding():
		return 
		
	var object = ray.get_collider()
	var interactable = null
	
	if object.has_method("interact"):
		interactable = object
	elif object.get_parent().has_method("interact"):
		interactable = object.get_parent()
		
	if interactable:
		prompt.visible = true
		
		if interactable.has_method("get_interaction_text"):
			prompt.text = interactable.get_interaction_text()
