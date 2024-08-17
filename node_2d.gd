extends Node2D

signal noted(points: float)

@export var offset = 0.0

@export_global_file var track: String


var inputs = ["one", "two", "three", "four"]
@onready var keys: Node2D = $Keys
#@onready var notes: Node2D = $Notes

func _ready() -> void:
	$AudioStreamPlayer.stream = load(track)
	$AudioStreamPlayer.play(offset)

func _process(_delta: float) -> void:
	for i in inputs.size():
		var input = inputs[i]
		var key = keys.get_child(i)

		if Input.is_action_just_pressed(input):
			key.modulate = Color.BLACK

			if key.has_overlapping_areas():
				var note = key.get_overlapping_areas()[0]
				note.queue_free()
				noted.emit(key.global_position.y - note.global_position.y)


		if Input.is_action_just_released(input):
			key.modulate = Color.WHITE
