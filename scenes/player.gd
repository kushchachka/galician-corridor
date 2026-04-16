extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var is_attacking = false

func _physics_process(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		sprite.play("attack")

	if is_attacking:
		velocity.x = 0
		move_and_slide()
		return

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		sprite.play("walk")

		if direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "attack":
		is_attacking = false
		sprite.play("idle")
