extends CanvasLayer

var points = 0
@onready var label: Label = $Control/MarginContainer/Label

func _ready() -> void:
	get_parent().noted.connect(add_points)

func add_points(more_points: float):
	points += floori((1 / (abs(more_points) / 10)) * 100)
	label.text = "Points: " + str(points)
