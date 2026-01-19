extends MarginContainer

func _ready():
	MusicManager.play_music(preload("res://Assets/Audio/ES_Sacrifice - Dream Cave (Créditos).ogg"))
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept")):
		yield(get_tree().create_timer(0.25), "timeout")
		get_tree().quit()
		
