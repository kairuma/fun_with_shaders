extends Node2D

# Built In Functions

func _ready() -> void:
	randomize()
	var the_chosen_one: int = randi() % $"%Characters".get_child_count()
	for i in $"%Characters".get_child_count():
		$"%Characters".get_child(i).visible = (i == the_chosen_one)

# Public Functions

func set_water_shader_param(param: String, value) -> void:
	$"%Water".get_material().set_shader_param(param, value)
