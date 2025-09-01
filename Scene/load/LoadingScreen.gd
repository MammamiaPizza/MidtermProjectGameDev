extends Node2D
# Loading.gd# LoadingScreen.gd

var loader
var load_progress = 0.0
@export var target_scene = null
var checking = true
var loaded_scene = null

func _ready():
	# เริ่มโหลดแบบ background
	$AnimatedSprite2D.play("start")
	await $AnimatedSprite2D.animation_finished
	if target_scene != "":
		# ใช้ threaded request แทน interactive
		var err = ResourceLoader.load_threaded_request(target_scene)
		if err != OK:
			push_error("โหลด scene ไม่ได้: %s" % target_scene)
	print(target_scene)

func _process(delta):
	if checking and target_scene != "":
		var status = ResourceLoader.load_threaded_get_status(target_scene)

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			checking = false   # ✅ ปิด loop ไม่ให้เข้าอีก
			_start_transition()

func _start_transition() -> void:
	# โหลดเสร็จแล้ว ดึง scene มาเก็บ
	loaded_scene = ResourceLoader.load_threaded_get(target_scene)
	# เล่น stop animation
	$AnimatedSprite2D.play("stop")
	# รอจนกว่าจะจบ
	await $AnimatedSprite2D.animation_finished
	# พอจบแล้วเปลี่ยน scene
	get_tree().change_scene_to_packed(loaded_scene)
