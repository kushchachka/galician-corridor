extends CanvasLayer

@onready var panel = $Panel
@onready var resume_button = $"Panel/HBoxContainer/MarginContainer/VBoxContainer/Resume"
@onready var main_menu_button = $"Panel/HBoxContainer/MarginContainer/VBoxContainer/Main Menu"
@onready var quit_button = $"Panel/HBoxContainer/MarginContainer/VBoxContainer/Quit"

func _ready() -> void:
	
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed) 
	quit_button.pressed.connect(_on_quit_pressed)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !get_tree().paused:
			pause_game()
		else:
			resume_game()


func pause_game():
	self.show()
	get_tree().paused = true

	panel.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(panel, "modulate", Color(1, 1, 1, 1), 0.3)


func resume_game():
	get_tree().paused = false

	var tween = create_tween()
	tween.tween_property(panel, "modulate", Color(1, 1, 1, 0), 0.3)
	await tween.finished
	
	self.hide()


func _on_resume_pressed() -> void:
	resume_game()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/control.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
