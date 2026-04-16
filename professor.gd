extends CharacterBody2D

@export var speed = 80
@export var chase_speed = 120
@export var patrol_distance = 250
@export var attack_range = 60 

@onready var anim = $AnimatedSprite2D
@onready var area_detection = $Area2D 

var player = null
var start_position: Vector2
var direction = 1
var state = "patrol"
var is_busy = false
var can_hit = true

func _ready():
	start_position = global_position
	player = get_tree().get_first_node_in_group("player")
	
	if area_detection:
		area_detection.body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	if is_busy or player == null:
		move_and_slide() 
		return
	
	var dist = global_position.distance_to(player.global_position)
	
	if dist <= attack_range and can_hit:
		start_attack_action()
		return

	if dist < 200:
		state = "chase"
	elif dist > 300:
		state = "patrol"
	
	match state:
		"patrol":
			patrol_logic()
		"chase":
			chase_logic()
	
	move_and_slide()

func patrol_logic():
	velocity.x = direction * speed
	velocity.y = 0
	anim.play("walk")
	anim.flip_h = velocity.x < 0
	
	if abs(global_position.x - start_position.x) > patrol_distance:
		if (global_position.x > start_position.x and direction > 0) or (global_position.x < start_position.x and direction < 0):
			direction *= -1

func chase_logic():
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * chase_speed
	anim.play("walk")
	anim.flip_h = velocity.x < 0

func start_attack_action():
	is_busy = true
	velocity = Vector2.ZERO
	anim.play("attack")
	
	print("Професор намагається вас завалити!")
	
	await get_tree().create_timer(0.8).timeout 
	
	if global_position.distance_to(player.global_position) <= attack_range + 10:
		if player.has_method("get_is_protecting") and not player.get_is_protecting():
			print("Студентка не встигла! Програш.")
			get_tree().reload_current_scene()
	
	is_busy = false

func _on_body_entered(body):
	if body.is_in_group("player") and can_hit:
		var is_p = body.get_is_protecting() if body.has_method("get_is_protecting") else false
		var is_a = body.get_is_attacking() if body.has_method("get_is_attacking") else false
		
		if is_p:
			apply_reaction("stunned", 150, 0.6)
		elif is_a:
			apply_reaction("knockback", 400, 0.8)

func apply_reaction(type, force, time):
	is_busy = true
	can_hit = false
	anim.play("idle") 
	
	var push_dir = (global_position - player.global_position).normalized()
	velocity = push_dir * force
	
	await get_tree().create_timer(time).timeout
	
	is_busy = false
	can_hit = true
	state = "patrol"
