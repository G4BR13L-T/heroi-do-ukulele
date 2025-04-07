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
	{ "time": 0.5, "lane": 1 },
	{ "time": 1.2, "lane": 0 },
	{ "time": 1.8, "lane": 2 },
	{ "time": 2.5, "lane": 3 },
	{ "time": 3.1, "lane": 1 },
	{ "time": 4.0, "lane": 0 },
	{ "time": 4.6, "lane": 2 },
	{ "time": 5.3, "lane": 3 },
	{ "time": 6.0, "lane": 1 },
	{ "time": 6.7, "lane": 0 },
	{ "time": 7.3, "lane": 2 },
	{ "time": 8.0, "lane": 3 },
	{ "time": 8.8, "lane": 0 },
	{ "time": 9.5, "lane": 1 },
	{ "time": 10.2, "lane": 2 },
	{ "time": 10.9, "lane": 3 },
	{ "time": 11.7, "lane": 1 },
	{ "time": 12.4, "lane": 0 },
	{ "time": 13.0, "lane": 2 },
	{ "time": 13.7, "lane": 3 },
	{ "time": 14.5, "lane": 0 },
	{ "time": 15.2, "lane": 1 },
	{ "time": 15.9, "lane": 2 },
	{ "time": 16.6, "lane": 3 },
	{ "time": 17.4, "lane": 1 },
	{ "time": 18.1, "lane": 0 },
	{ "time": 18.7, "lane": 2 },
	{ "time": 19.4, "lane": 3 },
	{ "time": 20.2, "lane": 0 },
	{ "time": 20.9, "lane": 1 },
	{ "time": 21.6, "lane": 2 },
	{ "time": 22.3, "lane": 3 },
	{ "time": 23.1, "lane": 1 },
	{ "time": 23.8, "lane": 0 },
	{ "time": 24.4, "lane": 2 },
	{ "time": 25.1, "lane": 3 },
	{ "time": 25.9, "lane": 1 },
	{ "time": 26.6, "lane": 0 },
	{ "time": 27.2, "lane": 2 },
	{ "time": 27.9, "lane": 3 },
	{ "time": 28.7, "lane": 0 },
	{ "time": 29.4, "lane": 1 },
	{ "time": 30.1, "lane": 2 },
	{ "time": 30.8, "lane": 3 },
	{ "time": 31.6, "lane": 1 },
	{ "time": 32.3, "lane": 0 },
	{ "time": 32.9, "lane": 2 },
	{ "time": 33.6, "lane": 3 },
	{ "time": 34.4, "lane": 0 },
	{ "time": 35.1, "lane": 1 },
	{ "time": 35.8, "lane": 2 },
	{ "time": 36.5, "lane": 3 },
	{ "time": 37.3, "lane": 1 },
	{ "time": 38.0, "lane": 0 },
	{ "time": 38.6, "lane": 2 },
	{ "time": 39.3, "lane": 3 },
	{ "time": 40.1, "lane": 0 },
	{ "time": 40.8, "lane": 1 },
	{ "time": 41.5, "lane": 2 },
	{ "time": 42.2, "lane": 3 },
	{ "time": 43.0, "lane": 1 },
	{ "time": 43.7, "lane": 0 },
	{ "time": 44.3, "lane": 2 },
	{ "time": 45.0, "lane": 3 },
	{ "time": 45.8, "lane": 0 },
	{ "time": 46.5, "lane": 1 },
	{ "time": 47.2, "lane": 2 },
	{ "time": 47.9, "lane": 3 },
	{ "time": 48.7, "lane": 1 },
	{ "time": 49.4, "lane": 0 },
	{ "time": 50.0, "lane": 2 },
	{ "time": 50.7, "lane": 3 },
	{ "time": 51.5, "lane": 0 },
	{ "time": 52.2, "lane": 1 },
	{ "time": 52.9, "lane": 2 },
	{ "time": 53.6, "lane": 3 },
	{ "time": 54.4, "lane": 1 },
	{ "time": 55.1, "lane": 0 },
	{ "time": 55.7, "lane": 2 },
	{ "time": 56.4, "lane": 3 },
	{ "time": 57.2, "lane": 0 },
	{ "time": 57.9, "lane": 1 },
	{ "time": 58.6, "lane": 2 },
	{ "time": 59.3, "lane": 3 },
	{ "time": 60.1, "lane": 1 },
	{ "time": 60.8, "lane": 0 },
	{ "time": 61.4, "lane": 2 },
	{ "time": 62.1, "lane": 3 },
	{ "time": 62.9, "lane": 0 },
	{ "time": 63.6, "lane": 1 },
	{ "time": 64.3, "lane": 2 },
	{ "time": 65.0, "lane": 3 },
	{ "time": 65.8, "lane": 1 },
	{ "time": 66.5, "lane": 0 },
	{ "time": 67.1, "lane": 2 },
	{ "time": 67.8, "lane": 3 },
	{ "time": 68.6, "lane": 0 },
	{ "time": 69.3, "lane": 1 },
	{ "time": 70.0, "lane": 2 },
	{ "time": 70.7, "lane": 3 },
	{ "time": 71.5, "lane": 1 },
	{ "time": 72.2, "lane": 0 },
	{ "time": 72.8, "lane": 2 },
	{ "time": 73.5, "lane": 3 },
	{ "time": 74.3, "lane": 0 },
	{ "time": 75.0, "lane": 1 },
	{ "time": 75.7, "lane": 2 },
	{ "time": 76.4, "lane": 3 },
	{ "time": 77.2, "lane": 1 },
	{ "time": 77.9, "lane": 0 },
	{ "time": 78.5, "lane": 2 },
	{ "time": 79.2, "lane": 3 },
	{ "time": 80.0, "lane": 0 },
	{ "time": 80.7, "lane": 1 },
	{ "time": 81.4, "lane": 2 },
	{ "time": 82.1, "lane": 3 },
	{ "time": 82.9, "lane": 1 },
	{ "time": 83.6, "lane": 0 },
	{ "time": 84.2, "lane": 2 },
	{ "time": 84.9, "lane": 3 },
	{ "time": 85.7, "lane": 0 },
	{ "time": 86.4, "lane": 1 },
	{ "time": 87.1, "lane": 2 },
	{ "time": 87.8, "lane": 3 },
	{ "time": 88.6, "lane": 1 },
	{ "time": 89.3, "lane": 0 },
	{ "time": 89.9, "lane": 2 },
	{ "time": 90.6, "lane": 3 },
	{ "time": 91.4, "lane": 0 },
	{ "time": 92.1, "lane": 1 },
	{ "time": 92.8, "lane": 2 },
	{ "time": 93.5, "lane": 3 },
	{ "time": 94.3, "lane": 1 },
	{ "time": 95.0, "lane": 0 },
	{ "time": 95.6, "lane": 2 },
	{ "time": 96.3, "lane": 3 },
	{ "time": 97.1, "lane": 0 },
	{ "time": 97.8, "lane": 1 },
	{ "time": 98.5, "lane": 2 },
	{ "time": 99.2, "lane": 3 },
	{ "time": 100.0, "lane": 1 },
	{ "time": 100.7, "lane": 0 },
	{ "time": 101.3, "lane": 2 },
	{ "time": 102.0, "lane": 3 },
	{ "time": 102.8, "lane": 0 },
	{ "time": 103.5, "lane": 1 },
	{ "time": 104.2, "lane": 2 },
	{ "time": 104.9, "lane": 3 },
	{ "time": 105.7, "lane": 1 },
	{ "time": 106.4, "lane": 0 },
	{ "time": 107.0, "lane": 2 },
	{ "time": 107.7, "lane": 3 },
	{ "time": 108.5, "lane": 0 },
	{ "time": 109.2, "lane": 1 },
	{ "time": 109.9, "lane": 2 },
	{ "time": 110.6, "lane": 3 },
	{ "time": 111.4, "lane": 1 },
	{ "time": 112.1, "lane": 0 },
	{ "time": 112.7, "lane": 2 },
	{ "time": 113.4, "lane": 3 },
	{ "time": 114.2, "lane": 0 },
	{ "time": 114.9, "lane": 1 },
	{ "time": 115.6, "lane": 2 },
	{ "time": 116.3, "lane": 3 },
	{ "time": 117.1, "lane": 1 },
	{ "time": 117.8, "lane": 0 },
	{ "time": 118.4, "lane": 2 },
	{ "time": 119.1, "lane": 3 },
	{ "time": 119.9, "lane": 0 },
	{ "time": 120.6, "lane": 1 },
	{ "time": 121.3, "lane": 2 },
	{ "time": 122.0, "lane": 3 },
	{ "time": 122.8, "lane": 1 },
	{ "time": 123.5, "lane": 0 },
	{ "time": 124.1, "lane": 2 },
	{ "time": 124.8, "lane": 3 },
	{ "time": 125.6, "lane": 0 },
	{ "time": 126.3, "lane": 1 },
	{ "time": 127.0, "lane": 2 },
	{ "time": 127.7, "lane": 3 },
	{ "time": 128.5, "lane": 1 },
	{ "time": 129.2, "lane": 0 },
	{ "time": 129.8, "lane": 2 },
	{ "time": 130.5, "lane": 3 },
	{ "time": 131.3, "lane": 0 },
	{ "time": 132.0, "lane": 1 },
	{ "time": 132.7, "lane": 2 },
	{ "time": 133.4, "lane": 3 },
	{ "time": 134.2, "lane": 1 },
	{ "time": 134.9, "lane": 0 },
	{ "time": 135.5, "lane": 2 },
	{ "time": 136.2, "lane": 3 },
	{ "time": 137.0, "lane": 0 },
	{ "time": 137.7, "lane": 1 },
	{ "time": 138.4, "lane": 2 },
	{ "time": 139.1, "lane": 3 },
	{ "time": 139.9, "lane": 1 },
	{ "time": 140.6, "lane": 0 },
	{ "time": 141.2, "lane": 2 },
	{ "time": 141.9, "lane": 3 },
	{ "time": 142.7, "lane": 0 },
	{ "time": 143.4, "lane": 1 },
	{ "time": 144.1, "lane": 2 },
	{ "time": 144.8, "lane": 3 },
	{ "time": 145.6, "lane": 1 },
	{ "time": 146.3, "lane": 0 },
	{ "time": 146.9, "lane": 2 },
	{ "time": 147.6, "lane": 3 },
	{ "time": 148.4, "lane": 0 },
	{ "time": 149.1, "lane": 1 },
	{ "time": 149.8, "lane": 2 },
	{ "time": 150.5, "lane": 3 },
	{ "time": 151.3, "lane": 1 },
	{ "time": 152.0, "lane": 0 },
	{ "time": 152.6, "lane": 2 },
	{ "time": 153.3, "lane": 3 },
	{ "time": 154.1, "lane": 0 },
	{ "time": 154.8, "lane": 1 },
	{ "time": 155.5, "lane": 2 },
	{ "time": 156.2, "lane": 3 },
	{ "time": 157.0, "lane": 1 },
	{ "time": 157.7, "lane": 0 },
	{ "time": 158.4, "lane": 2 },
	{ "time": 159.1, "lane": 3 },
	{ "time": 159.9, "lane": 0 },
	{ "time": 160.6, "lane": 1 },
	{ "time": 161.3, "lane": 2 },
	{ "time": 162.0, "lane": 3 },
	{ "time": 162.8, "lane": 1 },
	{ "time": 163.5, "lane": 0 },
	{ "time": 164.1, "lane": 2 },
	{ "time": 164.8, "lane": 3 },
	{ "time": 165.6, "lane": 0 },
	{ "time": 166.3, "lane": 1 },
	{ "time": 167.0, "lane": 2 },
	{ "time": 167.7, "lane": 3 },
	{ "time": 168.5, "lane": 1 },
	{ "time": 169.2, "lane": 0 },
	{ "time": 169.8, "lane": 2 },
	{ "time": 170.5, "lane": 3 },
	{ "time": 171.3, "lane": 0 },
	{ "time": 172.0, "lane": 1 },
	{ "time": 172.7, "lane": 2 },
	{ "time": 173.4, "lane": 3 },
	{ "time": 174.2, "lane": 1 },
	{ "time": 174.9, "lane": 0 },
	{ "time": 175.5, "lane": 2 },
	{ "time": 176.2, "lane": 3 },
	{ "time": 177.0, "lane": 0 },
	{ "time": 177.7, "lane": 1 },
	{ "time": 178.4, "lane": 2 }]

var nota_atual: int = 1
var posicao_x: int = -150
var captadores = []
var pontuacao: float = 0

func _ready() -> void:
	criar_captadores()

func _process(delta: float) -> void:
	for i in range(4):
		if Input.is_action_just_pressed("captador" + str(i + 1)):
			captadores[i].mostrar_explosao()
			pontuacao += captadores[i].captou_nota()
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
	pontuacao += -10
	atualiza_placar()

func gerar_nota(_nota, _tempo) -> void:
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
	if ultima_nota < musica.size():
		var nota = musica[ultima_nota]
		gerar_nota(nota["lane"],nota["time"])
		timer.wait_time = nota["time"] - previous_time
		timer.start()
		previous_time = nota["time"]
		ultima_nota += 1
	else:
		timer.stop()
		for child in get_children():
			child.set_process(false)

func atualiza_placar() -> void:
	if pontuacao < 0:
		pontuacao = 0
	placar.text = str(pontuacao).pad_zeros(6).pad_decimals(0)
