extends CanvasLayer

@onready var keys_container = $PanelContainer/KeysContainer
var player = null

func _ready():
	find_player()
	update_keys_display(0)

func _process(_delta):
	if not is_instance_valid(player):
		find_player()
	else:
		update_keys_display(player.keys_collected)

func find_player():
	var nodes = get_tree().get_nodes_in_group("player")
	for node in nodes:
		if node is CharacterBody2D:
			player = node
			break

func update_keys_display(count):
	if not keys_container: return
	
	var icons = keys_container.get_children()
	for i in range(icons.size()):
		if i < count:
			icons[i].modulate = Color(1, 1, 1, 1) 
		else:
			icons[i].modulate = Color(0, 0, 0, 0.4)
