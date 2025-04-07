extends Area2D

@export var velocidade: float = 200.0
@onready var sprite_2d: Sprite2D = $Sprite2D

signal nota_vazou

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.y > get_viewport_rect().size.y + 40):
		nota_vazou.emit()
		queue_free()
	position.y += velocidade * delta
