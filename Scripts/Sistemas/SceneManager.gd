extends Node

const SCENE_ROUTES = {
	"Mundo": "res://Cenas/Exploração/Mapa.tscn",
	"Batalha": "res://Cenas/Combate/Cena de Batalha.tscn"
	
}

func set_scene(scene: String):
	if SCENE_ROUTES.has(scene):
		get_tree().change_scene_to_file(SCENE_ROUTES[scene])
	else:
		print("set_scene error: could not find scene" + scene)
		
