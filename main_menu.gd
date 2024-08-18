extends Control

@export_file("*.tscn") var main_game_scene: String

func _ready() -> void:
	if FileAccess.file_exists("user://score.txt"):
		var save = FileAccess.open("user://score.txt", FileAccess.READ)
		$VBoxContainer/Label.text = "Best: " + str(save.get_64())
	#print(has_save)

func _on_button_pressed() -> void:
	SceneManager.transition_to(main_game_scene)
