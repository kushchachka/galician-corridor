extends CanvasLayer

@onready var label = $MarginContainer/Label
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	if player:
		label.text = "Ключі: " + str(player.keys)
