extends CanvasLayer

signal game_started

var points = 0
@onready var label: Label = $Control/MarginContainer/Label
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$AnimationPlayer.play("countdown")
	get_parent().noted.connect(add_points)


func add_points(more_points: float):
	points += floori((1 / (abs(more_points) / 10)) * 100)
	label.text = "Points: " + str(points)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$Control/MarginContainer/Countdown.hide()
	game_started.emit()
