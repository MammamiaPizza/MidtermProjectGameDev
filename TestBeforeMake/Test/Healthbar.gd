extends ProgressBar

@export var Player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	Player.gethit.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = Player.hp * 100 / 100
