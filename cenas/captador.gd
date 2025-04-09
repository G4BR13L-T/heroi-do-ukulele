extends Area2D

class_name Captador

@onready var explosion: Sprite2D = $explosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func captou_nota() -> int:
	if(has_overlapping_areas()):
		var nota = get_overlapping_areas()[0]
		var diferenca = position.y - nota.position.y
		print(diferenca)
		if(diferenca > -8 && diferenca < 8):
			print("Perfect!")
			nota.queue_free()
			return 100
		elif(diferenca > -16 && diferenca < 16):
			print("Great!")
			nota.queue_free()
			return 50
		elif (diferenca > -32 && diferenca < 32):
			print("...")
			nota.queue_free()
			return 25
		elif (diferenca > -64 && diferenca < 64):
			print("Bad")
			nota.queue_free()
			return 5
	else:
		print("Out")
		return -15
	return 0

func mostrar_explosao() -> void:
	explosion.show()
	await get_tree().create_timer(0.1).timeout  
	explosion.hide()
