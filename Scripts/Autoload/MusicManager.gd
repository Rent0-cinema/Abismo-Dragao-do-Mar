extends Node

onready var player = AudioStreamPlayer.new()

func _ready():
	add_child(player)
	player.bus = "Music"

func play_music(music):
	if player.stream == music:
		return

	player.stream = music
	player.stream.loop = true
	player.play()
