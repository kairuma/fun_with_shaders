extends Node2D

onready var sunset_scene: Resource = preload("res://scene/Sunset.tscn")
onready var sunset: Node = $ViewportContainer/Viewport/Sunset

# Built In Functions

func _ready() -> void:
	randomize()

# Public Functions

func reset_scene() -> void:
	sunset.queue_free()
	sunset = sunset_scene.instance()
	if sunset.connect("reset", $AnimationPlayer, "play", ["fade_out"]) != OK:
		get_tree().quit()
		return
	if sunset.connect("toggle_crt", self, "_toggle_crt") != OK:
		get_tree().quit()
		return
	if sunset.connect("add_impact", self, "_add_impact") != OK:
		get_tree().quit()
		return
	$ViewportContainer.get_material().set_shader_param("crt", false)
	$ViewportContainer/Viewport.add_child(sunset)
	sunset.reset_shader_params()
	$AnimationPlayer.play("fade_in")

# Private Functions

func _set_impact(value: float) -> void:
	$ViewportContainer.get_material().set_shader_param("impact", value)

# Signal Functions

func _toggle_crt() -> void:
	$ViewportContainer.get_material().set_shader_param("crt", !$ViewportContainer.get_material().get_shader_param("crt"))

func _add_impact() -> void:
	$ImpactPlayer.pitch_scale = randf() * 0.25 + 0.8
	$ImpactPlayer.play()
	$ViewportContainer.get_material().set_shader_param("impact_center", Vector2(randf() * 0.5 + 0.25, randf() * 0.5 + 0.25))
	var tween: SceneTreeTween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	#warning-ignore:return_value_discarded
	tween.tween_method(self, "_set_impact", 1.0, 0.0, 0.8)
