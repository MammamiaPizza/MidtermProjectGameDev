extends Node2D

@onready var camera = $Camera2D
var dialogfinnish = false
var move_speed = 200 # pixels per second
var move_dir = 0 # -1 = left, 1 = right, 0 = stop

func _ready() -> void:
	if Bossclean.getbossdie() == 0:
		$Camera2D/Control/TextureRect2/Label.set_text("สวัสดีฉันชื่อโชระเป็นOperatorของนายก็แค่นั้นแหละ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()

		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/เอาล่ะ...ฉันจะอธิบายแผนของมิชชั่นนี้ให้ฟัง.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("เอาล่ะ ฉันจะอธิบายแผนของมิชชั่นนี้ให้ฟัง")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/ในหอคอยแห่งนี้...มีเทพโบราณทั้งสี่หลับใหลอยู่.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("ในหอคอยแห่งนี้ มีเทพโบราณทั้งสี่หลับใหลอยู่")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/เทพเจ้ามักจะหยิ่งในศักดิ์ศรี และไม่ชอบสุงสิงกัน.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("เทพเจ้ามักจะหยิ่งในศักดิ์ศรี และไม่ชอบสุงสิงกัน")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/ดังนั้น ภารกิจของนายคือการลอบเข้าไปในที่พำนักของเหล่าเทพ และสังหารพวกมันทีละตน.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("ดังนั้น ภารกิจของนายคือการลอบเข้าไปในที่พำนักของเหล่าเทพ และสังหารพวกมันทีละตน")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/แต่ต้องระวังอย่างนึง เทพพวกนั้นมีพลังที่มากเกินมนุษย์จะเข้าใจ.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("แต่ต้องระวังอย่างนึง เทพพวกนั้นมีพลังที่มากเกินมนุษย์จะเข้าใจ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/เดี๋ยวฉันจะอธิบายความสามารถของพวกมันให้ฟัง จำให้ดีละ.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("เดี๋ยวฉันจะอธิบายความสามารถของพวกมันให้ฟัง จำให้ดีละ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		dialogend()
	elif Bossclean.getbossdie() == 1 :
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/สำเร็จไปแล้ว1นะ แต่อย่ารีบดีใจไป เพราะMissionมันพึ่งเริ่ม.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("สำเร็จไปแล้ว1นะ แต่อย่ารีบดีใจไป เพราะMissionมันพึ่งเริ่ม")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
	elif Bossclean.getbossdie() == 2 :
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/ครึ่งทางแล้วสินะ ยังต้องพยายามอีกหน่อยนะ.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("ครึ่งทางแล้วสินะ ยังต้องพยายามอีกหน่อยนะ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
	elif Bossclean.getbossdie() == 3 :
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/เหลืออีกแค่หนึ่งสินะ อย่าประมาทละ.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("เหลืออีกแค่หนึ่งสินะ อย่าประมาทละ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
	elif Bossclean.getbossdie() == 4 :
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/ยินดีด้วยนะ นายทำสำเร็จแล้วละ.ogg"))
		$Camera2D/Control/TextureRect2/Label.set_text("ยินดีด้วยนะ นายทำสำเร็จแล้วละ")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		camera.set_enabled(false)
		loading_scene.target_scene = "res://Scene/UI/MainMenu.tscn"
		get_tree().current_scene.add_child(loading_scene)
		
func dialogend() :	
	$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/Voice/เดี๋ยวเถอะ ฉันยังพูดไม่จบเลย ทำไมตัดสายแล้วละ!.ogg"))
	$Camera2D/Control/TextureRect2/Label.set_text("เดี๋ยวเถอะ ฉันยังพูดไม่จบเลย ทำไมตัดสายแล้วละ!")
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	dialogfinnish = true
	$AudioStreamPlayer2D.stop()
	$Camera2D/Control.position.x += 700
func _process(delta):
	if move_dir != 0:
		camera.position.x += move_dir * move_speed * delta
		# ข้อจำกัดขอบซ้าย-ขวา
		camera.position.x = clamp(camera.position.x, -2237, 2085)

func _on_area_2d_mouse_entered() -> void: # right
	print("onright")
	move_dir = -1

func _on_area_2d_mouse_exited() -> void:
	move_dir = 0
	print("offright")

func _on_area_2d_2_mouse_entered() -> void: # left
	print("onleft")
	move_dir = 1

func _on_area_2d_2_mouse_exited() -> void:
	move_dir = 0
	print("offleft")

func _on_area_2d_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("door"):
		$AnimatedSprite2D.play("preopen")
		$AnimatedSprite2D2.play("preopen")
		$AnimatedSprite2D3.play("preopen")
		$AnimatedSprite2D4.play("preopen")

	pass # Replace with function body.


func _on_area_2d_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("door"):
		$AnimatedSprite2D.play_backwards("preopen")
		$AnimatedSprite2D2.play_backwards("preopen")
		$AnimatedSprite2D3.play_backwards("preopen")
		$AnimatedSprite2D4.play_backwards("preopen")


func deathdoor() -> void:
	if !Bossclean.getd():
		if !dialogfinnish:
			dialogend()
		 # Replace with function body.
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		camera.set_enabled(false)

		loading_scene.target_scene = "res://Scene/Level/DeadLevel.tscn"
		get_tree().current_scene.add_child(loading_scene)
		pass
	else:
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/dialog/voice/โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง.wav"))
		$Camera2D/Control/TextureRect2/Label.set_text("โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
func lifedoor() -> void:
	 # Replace with function body.
	if !Bossclean.getl():
		if !dialogfinnish:
			dialogend()
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		camera.set_enabled(false)

		loading_scene.target_scene = "res://Scene/Level/LifeLevel.tscn"
		get_tree().current_scene.add_child(loading_scene)
		pass
	else:
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/dialog/voice/โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง.wav"))
		$Camera2D/Control/TextureRect2/Label.set_text("โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()
func dimensiondoor() -> void:
	if !Bossclean.getdi():
		if !dialogfinnish:
			dialogend()
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		
		camera.set_enabled(false)

		loading_scene.target_scene = "res://Scene/Level/DimensionLevel.tscn"
		get_tree().current_scene.add_child(loading_scene)
		pass # Replace with function body.
	else:
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/dialog/voice/โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง.wav"))
		$Camera2D/Control/TextureRect2/Label.set_text("โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()

func timedoor() -> void:
	if !Bossclean.gett():
		if !dialogfinnish:
			dialogend()	
		var loading_scene = preload("res://Scene/load/LoadingScreen.tscn").instantiate()
		camera.set_enabled(false)
		loading_scene.target_scene = "res://Scene/Level/TimeLevel.tscn"
		get_tree().current_scene.add_child(loading_scene)
		pass # Replace with function body.
	else:
		$AudioStreamPlayer2D.set_stream(load("res://asset/OperatorwithDialog/dialog/voice/โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง.wav"))
		$Camera2D/Control/TextureRect2/Label.set_text("โถ่ห้องนั้นนายเข้าไปแล้วนะลืมรึไง")
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$AudioStreamPlayer2D.stop()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
