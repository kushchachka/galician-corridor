extends Area2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle") 

func _on_body_entered(body):
	print("Контакт з: ", body.name)
	if body.is_in_group("player"):
		body.add_key()
		
		set_deferred("monitoring", false)
		
		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector2(0, -40), 0.3)
		tween.parallel().tween_property(self, "modulate:a", 0, 0.3)
		
		tween.finished.connect(queue_free)
