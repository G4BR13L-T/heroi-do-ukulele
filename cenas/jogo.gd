extends Node2D

@onready var timer: Timer = $Timer
@onready var placar: Label = $Placar

@export var cena_captador: PackedScene
@export var cena_nota: PackedScene

@export var img_nota1: Texture2D = preload("res://assets/Notas/platformPack_item001.png")
@export var img_nota2: Texture2D = preload("res://assets/Notas/platformPack_item002.png")
@export var img_nota3: Texture2D = preload("res://assets/Notas/platformPack_item003.png")
@export var img_nota4: Texture2D = preload("res://assets/Notas/platformPack_item004.png")

var previous_time: float = 0.0
var ultima_nota: int = 0
var musica = [
  {"lane": 0}, {"lane": 0}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1}, {"lane": 2}, {"lane": 2},
  {"lane": 0}, {"lane": 0}, {"lane": 3}, {"lane": 3}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0},
  {"lane": 2}, {"lane": 2}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1},
  {"lane": 1}, {"lane": 1}, {"lane": 2}, {"lane": 2}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1},
  {"lane": 0}, {"lane": 0}, {"lane": 3}, {"lane": 3}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0},
  {"lane": 2}, {"lane": 2}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1},
  {"lane": 1}, {"lane": 1}, {"lane": 2}, {"lane": 2}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1},
  {"lane": 3}, {"lane": 3}, {"lane": 2}, {"lane": 2}, {"lane": 1}, {"lane": 1}, {"lane": 0}, {"lane": 0},
  {"lane": 1}, {"lane": 1}, {"lane": 2}, {"lane": 2}, {"lane": 0}, {"lane": 0}, {"lane": 1}, {"lane": 1},
  {"lane": 2}, {"lane": 2}, {"lane": 0}, {"lane": 0}
]

var nota_atual: int = 1
var posicao_x: int = -150
var captadores = []
var pontuacao: float = 0
var pontos = [0,0,0,0,0,0]#perfeito, bom, ..., ruim, fora, vazou

func _ready() -> void:
	criar_captadores()

func _process(delta: float) -> void:
	for i in range(4):
		if Input.is_action_just_pressed("captador" + str(i + 1)):
			captadores[i].mostrar_explosao()
			var retorno: int = captadores[i].captou_nota()
			if retorno == 100:
				pontos[0] += 1
			elif retorno == 50:
				pontos[1] += 1
			elif retorno == 25:
				pontos[2] += 1
			elif retorno == 5:
				pontos[3] += 1
			elif retorno == -15:
				pontos[4] +=1
			pontuacao += retorno
			atualiza_placar()

func criar_captadores():
	var viewport_size: Vector2 = get_viewport_rect().size
	for i: int in range(4):
		captadores.append(cena_captador.instantiate())
		captadores[i].position.y = viewport_size.y - 70
		captadores[i].position.x = viewport_size.x/2 + posicao_x
		add_child(captadores[i])
		posicao_x += 100

func _on_nota_vazou() -> void:
	pontos[5] += 1
	pontuacao += -10
	atualiza_placar()

func gerar_nota(_nota) -> void:
	var nota = cena_nota.instantiate()
	var viewport_size: Vector2 = get_viewport_rect().size
	add_child(nota)
	nota.connect("nota_vazou", _on_nota_vazou)
	if(_nota == 0):
		nota.sprite_2d.texture = img_nota1
		nota.position.x = viewport_size.x/2 - 150
		nota.position.y -= 30
	elif(_nota == 1):
		nota.sprite_2d.texture = img_nota2
		nota.position.x = viewport_size.x/2 - 50
		nota.position.y -= 30
	elif(_nota == 2):
		nota.sprite_2d.texture = img_nota3
		nota.position.x = viewport_size.x/2 + 50
		nota.position.y -= 30
	else:
		nota.sprite_2d.texture = img_nota4
		nota.position.x = viewport_size.x/2 + 150
		nota.position.y -= 30

func _on_timer_timeout() -> void:
	var randTime: float = randf_range(0.1,1.5)
	if ultima_nota < musica.size():
		var nota = musica[ultima_nota]
		gerar_nota(nota["lane"])
		timer.wait_time = randTime
		timer.start()
		ultima_nota += 1
	else:
		ultima_nota = 0
		timer.wait_time = 0.1
		timer.start()

func atualiza_placar() -> void:
	if pontuacao < 0:
		pontuacao = 0
	placar.text = str(pontuacao).pad_zeros(6).pad_decimals(0)


func _quando_musica_finalizada() -> void:
	timer.stop()
	print("\tParabéns você acertou perfeitamente ", pontos[0], " vezes, também fez ", pontos[1], " acertos, \n", pontos[2], " foram aceitáveis, fez também ", pontos[3], " acertos ruins, \nmas como nem tudo são flores, você tambem clicou fora ", pontos[4], " vezes e deixou cair ", pontos[5], " notas.\n\tQue boa parida!")
	for child in get_children():
		print(child)
		child.set_process(false)
