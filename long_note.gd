class_name LongNote
extends Area2D

var shrinking = false

func _process(delta: float) -> void:
	if shrinking:
		scale.y -= delta * (1.0 / get_parent().seconds_per_beat) * 12
		#position.y -= delta * (1.0 / get_parent().seconds_per_beat) * 50
		scale.y = clamp(scale.y, 0, INF)
