extends CanvasLayer

var time_elapsed: float = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta
	$MarginContainer/ScoreLabel.text = "Час у коледжі: " + str(int(time_elapsed)) + "с"
