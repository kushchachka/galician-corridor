extends CharacterBody2D

@export var speed = 150
@onready var anim = $AnimatedSprite2D

var is_attacking = false
var is_protecting = false
var keys = 0  # Змінна для підрахунку ключів

func _physics_process(_delta):
	# Якщо атакуємо або захищаємось — не рухаємось
	if is_attacking or is_protecting:
		velocity = Vector2.ZERO 
	else:
		handle_movement()
	
	move_and_slide()
	update_animations()

func handle_movement():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed

func _input(event):
	# Атака
	if event.is_action_pressed("attack") and not is_attacking:
		attack()
	
	# Захист
	if event.is_action_pressed("protection"):
		is_protecting = true
	elif event.is_action_released("protection"):
		is_protecting = false

func attack():
	is_attacking = true
	anim.play("attack") 
	await get_tree().create_timer(0.5).timeout
	is_attacking = false

func update_animations():
	if is_attacking: return
	
	if is_protecting:
		anim.play("protection")
		return

	if velocity.length() > 0:
		anim.play("walk")
		anim.flip_h = velocity.x < 0
	else:
		anim.play("idle")

# Функція додавання ключа
func add_key():
	keys += 1
	print("Ключі підібрано! Всього:", keys)

# Перевірка для дверей
func use_key() -> bool:
	if keys > 0:
		keys -= 1
		return true
	return false
