extends CanvasLayer

# Змінні для кнопок
var resume_button
var main_menu_button
var quit_button

func _ready() -> void:
	
	resume_button = get_node("HBoxContainer/MarginContainer/VBoxContainer/Resume")
	main_menu_button = get_node("HBoxContainer/MarginContainer/VBoxContainer/Main Menu")
	quit_button = get_node("HBoxContainer/MarginContainer/VBoxContainer/Quit")
	
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	self.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"): 
		if !get_tree().paused:
			pause_game()
		else:
			resume_game()

func pause_game():
	self.show()
	get_tree().paused = true

func resume_game():
	get_tree().paused = false
	self.hide()

func _on_resume_pressed() -> void:
	resume_game()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Control.tscn") 

func _on_quit_pressed() -> void:
	get_tree().quit()
	
