extends Area2D

@export var velocidade: float = 250.0
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.y > get_viewport_rect().size.y):
		queue_free()
	position.y += velocidade * delta
