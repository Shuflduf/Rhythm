extends Node2D

var inputs = ["one", "two", "three", "four"]
@onready var keys: Node2D = $Keys
@onready var notes: Node2D = $Notes

func _process(delta: float) -> void:
	notes.position.y += delta * 100
	for i in inputs.size():
		var input = inputs[i]

		if Input.is_action_just_pressed(input):
			keys.get_child(i).modulate = Color.BLACK
			keys.get_child(i).get_overlapping_areas()[0].queue_free()

		if Input.is_action_just_released(input):
			keys.get_child(i).modulate = Color.WHITE
