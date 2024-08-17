extends Node2D

@export_global_file var track: String


var inputs = ["one", "two", "three", "four"]
@onready var keys: Node2D = $Keys
@onready var notes: Node2D = $Notes

func _ready() -> void:
	$AudioStreamPlayer.stream = load(track)
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	notes.position.y += delta * 300
	for i in inputs.size():
		var input = inputs[i]
		var key = keys.get_child(i)

		if Input.is_action_just_pressed(input):
			key.modulate = Color.BLACK
			if key.has_overlapping_areas():
				key.get_overlapping_areas()[0].queue_free()

		if Input.is_action_just_released(input):
			key.modulate = Color.WHITE
