extends Node2D

#warning-ignore:unused_signal
signal reset
#warning-ignore:unused_signal
signal toggle_crt
#warning-ignore:unused_signal
signal add_impact

onready var clouds: Array = [$"%Cloud1", $"%Cloud2", $"%Cloud3", $"%Cloud4"]

# Built In Functions

func _ready() -> void:
	randomize()
	for c in clouds:
		c.get_material().set_shader_param("time_offset", randf())
	$ParallaxBackground/ParallaxLayer/AnimationPlayer.seek(randf() * 180.0)
	set_process(true)

func _process(delta: float) -> void:
	$Camera2D.position = get_global_mouse_position() * 0.125 + Vector2(350, 262.5)

# Public Functions

func reset_shader_params() -> void:
	for c in clouds:
		c.get_material().set_shader_param("bottom_color", Color("ff4582"))
		c.get_material().set_shader_param("speed", 0.1)
	$"%Sky".get_material().set_shader_param("hue", 0.0)
	$"%Pool".set_water_shader_param("opacity", 0.25)
	$"%Pool".set_water_shader_param("wave_speed", 0.5)
	$"%Pool".set_water_shader_param("reflect_color", Color("9e2341"))

# Private Functions

# Signal Functions

func _toggle_cloud_popup(button_pressed: bool) -> void:
	$"%CloudPopup".visible = button_pressed

func _toggle_sky_popup(button_pressed: bool) -> void:
	$"%SkyPopup".visible = button_pressed

func _toggle_water_popup(button_pressed: bool) -> void:
	$"%WaterPopup".visible = button_pressed

func _set_cloud_color(color: Color) -> void:
	for c in clouds:
		c.get_material().set_shader_param("bottom_color", color)

func _set_cloud_speed(value: float) -> void:
	for c in clouds:
		c.get_material().set_shader_param("speed", value)

func _set_sky_hue_shift(value: float) -> void:
	$"%Sky".get_material().set_shader_param("hue", value)

func _set_water_opacity(value: float) -> void:
	$"%Pool".set_water_shader_param("opacity", value)

func _set_water_wave_speed(value: float) -> void:
	$"%Pool".set_water_shader_param("wave_speed", value)

func _set_water_reflect_color(color: Color) -> void:
	$"%Pool".set_water_shader_param("reflect_color", color)
