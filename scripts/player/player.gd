extends CharacterBody3D

var can_move := false
var door_opened := false

@export var speed := 3.5
@export var mouse_sensitivity := 0.002

@onready var head: Node3D = $Head
@onready var doorbell_sound: AudioStreamPlayer = get_tree().current_scene.get_node("Doorbell Sound")
@onready var black_screen: ColorRect = $"Wake Screen/Black Screen"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var snoring_sound: AudioStreamPlayer = get_tree().current_scene.get_node("Snoring Sound")

const GRAVITY := 9.8


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	snoring_sound.play()
	
	await get_tree().create_timer(4.0).timeout
	
	doorbell_sound.play()
	
	await get_tree().create_timer(4.0).timeout
	
	await get_tree().create_timer(1.5).timeout
	
	black_screen.visible = false
	animation_player.play("Wake Up")


func _unhandled_input(event):
	if not can_move:
		return
		
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		
		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-89),
			deg_to_rad(89)
		)
			
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event.is_action_pressed("interact"):
		_interact()


func _physics_process(delta):
	_update_interaction_prompt()
	
	if not can_move:
		velocity.x = 0
		velocity.y = 0
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	
	var input := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)

	
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Wake Up":
		can_move = true
