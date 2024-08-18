extends Node2D

signal noted(points: float)

@export_file("*.tscn") var main_menu: String

@export var offset = 0.0
@export_global_file var track: String


var inputs = ["one", "two", "three", "four"]
@onready var keys: Node2D = $Keys
#@onready var notes: Node2D = $Notes

func _ready() -> void:
	$AudioStreamPlayer.stream = load(track)
	
func start():
	$Level.moving = true
	$AudioStreamPlayer.play(offset)

func _process(_delta: float) -> void:
	for i in inputs.size():
		var input = inputs[i]
		var key = keys.get_child(i)
		var key_sprite = key.get_child(1)

		if Input.is_action_just_pressed(input):
			#key_sprite.modulate = Color.BLACK
			key_sprite.material.set_shader_parameter("new_colour", Color.BLACK)

			if key.has_overlapping_areas():
				var note = key.get_overlapping_areas()[0]
				if note is Note:
					note.queue_free()
				if note is LongNote:
					note.shrinking = true
				noted.emit(key.global_position.y - note.global_position.y)


		if Input.is_action_just_released(input):
			#key_sprite.modulate = Color.WHITE
			key_sprite.material.set_shader_parameter("new_colour", Color.WHITE)


func _on_event_detection_area_entered(_area: Area2D) -> void:
	if FileAccess.file_exists("user://score.txt"):
		var save = FileAccess.open("user://score.txt", FileAccess.READ)
		if $UI.points > save.get_64():
			FileAccess.open("user://score.txt", FileAccess.WRITE)\
					.store_64($UI.points)
	
	var tween = get_tree().create_tween()\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($AudioStreamPlayer, "volume_db", -80, 2)
	tween.parallel().tween_property($AudioStreamPlayer, "pitch_scale", 0, 2)
	
	await tween.finished
	SceneManager.transition_to(main_menu)

func _on_ui_game_started() -> void:
	start()
