extends Control

@export_file("*.tscn") var main_game_scene: String


func _on_button_pressed() -> void:
	SceneManager.transition_to(main_game_scene)
