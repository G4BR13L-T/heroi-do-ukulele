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
		if(diferenca > -50 && diferenca < 50):
			nota.queue_free()
			return 100.0 - diferenca
	return -20.0

func mostrar_explosao() -> void:
	explosion.show()
	await get_tree().create_timer(0.1).timeout  
	explosion.hide()
