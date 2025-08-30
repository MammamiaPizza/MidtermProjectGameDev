extends Node2D
# Loading.gd# LoadingScreen.gd


var loader
var load_progress = 0.0
@export var target_scene = "none"


func _ready():
	# เริ่มโหลดแบบ background
	$AnimatedSprite2D.play("start")
	loader = ResourceLoader.load(target_scene)

func _process(delta):
	if loader:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			# โหลดเสร็จ → เอา scene มาใช้
			$AnimatedSprite2D.play("stop")
			var scene = loader.get_resource()
			get_tree().change_scene_to_packed(scene)
