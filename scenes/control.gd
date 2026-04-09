extends Control


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
