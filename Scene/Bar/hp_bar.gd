extends TextureProgressBar

@onready var player  = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
	player.gethit.connect(update())
	
func update():
	value = player.hp
	
	
