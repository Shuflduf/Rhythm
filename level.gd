extends Node2D

@export var bpm = 120.0

var seconds_per_beat:
	get:
		return 60.0 / bpm

var offset = 0.0

func _ready() -> void:

	offset = get_parent().offset
	position.y = offset * (1.0 / seconds_per_beat) * 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * (1.0 / seconds_per_beat) * 200
