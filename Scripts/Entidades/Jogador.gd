extends Spatial


const batalha = preload("res://Cenas/Combate/Cena de Batalha.tscn")
const TRAVEL_TIME := 0.3

onready var front_ray := $FrontRay
onready var back_ray := $BackRay

var min_v = 0
var max_v = 100
var chance_de_batalha = 10
var tween

func _ready():
	encontro_aleatorio()
	
func encontro_aleatorio():
	 if rand_range(min_v, max_v) < chance_de_batalha:
		 entrar_em_batalha()

func entrar_em_batalha():
		get_parent().add_child(batalha.instance())
		queue_free()

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


