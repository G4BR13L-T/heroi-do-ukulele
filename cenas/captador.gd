extends Area2D

@onready var explosion: Sprite2D = $explosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func captou_nota() -> float:
	if(has_overlapping_areas()):
		var nota = get_overlapping_areas()[0]
		var diferenca = position.y - nota.position.y
		print(diferenca)
		if(diferenca > -8 && diferenca < 8):
			print("Perfect!")
			nota.queue_free()
			return 100.0
		elif(diferenca > -16 && diferenca < 16):
			print("Great!")
			nota.queue_free()
			return 50.0
		elif (diferenca > -32 && diferenca < 32):
			print("...")
			return 25.0
		elif (diferenca > -64 && diferenca < 64):
			print("Bad")
			return 5
	else:
		print("Out")
		return -15
	return -20

func mostrar_explosao() -> void:
	explosion.show()
	await get_tree().create_timer(0.1).timeout  
	explosion.hide()
