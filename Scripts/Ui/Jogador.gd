extends Spatial


const batalha = preload("res://Cenas/Combate/Cena de Batalha.tscn")
const TRAVEL_TIME := 0.3

onready var front_ray := $FrontRay
onready var back_ray := $BackRay

var min_v = 0
var max_v = 100
var chance_de_batalha = 8
var tween

func _ready():
	encontro_aleatorio()
	if Estado.player_transform != Transform():
		 set_physics_process(false)
		 set_process(false)
		 global_transform = Estado.player_transform
		 rotation.y = Estado.yaw
		 $Camera.rotation.x = Estado.pitch
		 set_physics_process(true)
		 set_process(true)
	
	
	
func encontro_aleatorio():
	 if rand_range(min_v, max_v) < chance_de_batalha:
		 start_battle()


func _physics_process(_delta):
	if tween is SceneTreeTween:
		if tween.is_running():
			return
	if Input.is_action_pressed("forward"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.FORWARD * 2), TRAVEL_TIME)
		encontro_aleatorio()
		
	if Input.is_action_pressed("back"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.BACK * 2), TRAVEL_TIME)
		encontro_aleatorio()
		
	if Input.is_action_pressed("left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
	if Input.is_action_pressed("right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)

func save_state():
	Estado.player_transform = global_transform
	Estado.yaw = rotation.y
	Estado.pitch = $Camera.rotation.x

func start_battle():
	save_state()
	Estado.last_scene = "res://Cenas/Exploração/Mapa.tscn"
	get_tree().change_scene("res://Cenas/Combate/Cena de Batalha.tscn")
