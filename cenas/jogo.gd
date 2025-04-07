extends Node2D

var captadores = []
@export var cena_captador: PackedScene
var posicao_x: int = -150

@onready var timer: Timer = $Timer
@export var cena_nota: PackedScene

@export var img_nota1: Texture2D = preload("res://assets/Planets/planet00.png")
@export var img_nota2: Texture2D = preload("res://assets/Planets/planet08.png")
@export var img_nota3: Texture2D = preload("res://assets/Planets/planet09.png")
@export var img_nota4: Texture2D = preload("res://assets/Planets/planet05.png")
var nota_atual: int = 1
var pontuacao: float = 0

func _ready() -> void:
	criar_captadores()
	
func criar_captadores():
	var viewport_size: Vector2 = get_viewport_rect().size
	for i: int in range(4):
		captadores.append(cena_captador.instantiate())
		captadores[i].position.y = viewport_size.y - 70
		captadores[i].position.x = viewport_size.x/2 + posicao_x
		add_child(captadores[i])
		posicao_x += 100

func _process(delta: float) -> void:
	for i in range(4):
		if Input.is_action_just_pressed("captador" + str(i + 1)):
			captadores[i].mostrar_explosao()
			pontuacao += captadores[i].captou_nota()

func _on_timer_timeout() -> void:
	var nota = cena_nota.instantiate()	
	var viewport_size: Vector2 = get_viewport_rect().size
	add_child(nota)
	if(nota_atual == 1):
		nota.sprite_2d.texture = img_nota1
		nota.position.x = viewport_size.x/2 - 150
	elif(nota_atual == 2):
		nota.sprite_2d.texture = img_nota2
		nota.position.x = viewport_size.x/2 - 50
	elif(nota_atual == 3):
		nota.sprite_2d.texture = img_nota3
		nota.position.x = viewport_size.x/2 + 50
	else:
		nota.sprite_2d.texture = img_nota4
		nota.position.x = viewport_size.x/2 + 150
		nota_atual = 0
	nota_atual += 1
