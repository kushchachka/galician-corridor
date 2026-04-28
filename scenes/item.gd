extends Area2D

@onready var anim = $AnimatedSprite2D
var taken = false 

func _ready():
	anim.play("idle") 

func _on_body_entered(body):
	if taken: return 
	if body.has_method("add_key"):
		taken = true
		body.add_key()
		
		set_deferred("monitoring", false)
		
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", position + Vector2(0, -50), 0.4)
		tween.parallel().tween_property(self, "modulate:a", 0, 0.3)
		
		tween.finished.connect(queue_free)
