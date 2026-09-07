extends MeshInstance3D

@onready var tv_feed_viewport = get_parent().get_node("TV Feed Viewport")

func _ready():
	visible = false
	var material = get_active_material(0) as StandardMaterial3D
	
	if material:
		material.albedo_texture = tv_feed_viewport.get_texture()
		material.emission_enabled = true
		material.emission_texture = tv_feed_viewport.get_texture()
		material.emission_energy_multiplier = 1.0
