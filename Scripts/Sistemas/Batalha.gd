extends Control

signal textbox_closed

export(Resource) var enemy = null

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false 

func _ready(): 
	set_health($Inimigo/ProgressBar, enemy.health, enemy.health)
	set_health($PaineldoJogador/DadosJogador/ProgressBar, Estado.current_health, Estado.max_health)
	$Inimigo/SpriteInimigo.texture = enemy.texture
	
	current_player_health = Estado.current_health
	current_enemy_health = enemy.health
	
	$CaixadeTexto.hide()
	$PaineldeActions.hide()
	
	display_text("Um %s Aparece!" % enemy.name.to_upper())
	yield(self, "textbox_closed")
	$PaineldeActions.show()
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d"%[health, max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept")) and $CaixadeTexto.visible:
		$CaixadeTexto.hide()
		emit_signal("textbox_closed")
		
func display_text(text):
		$PaineldeActions.hide()
		$CaixadeTexto.show()
		$CaixadeTexto/Label.text = text

func enemy_turn():
	display_text("%s ataca você ferozmente" % enemy.name)
	yield(self, "textbox_closed")
	
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("tremorzin")
		yield($AnimationPlayer, "animation_finished")
		display_text("Você defendeu com sucesso")
		yield(self, "textbox_closed")
	
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PaineldoJogador/DadosJogador/ProgressBar, current_player_health, Estado.max_health) 
		$AnimationPlayer.play("tremor")
		yield($AnimationPlayer, "animation_finished")
		display_text("%s deu %d de dano" % [enemy.name, enemy.damage])
		yield(self, "textbox_closed")
		
	$PaineldeActions.show()
	
func _on_Correr_pressed():
	display_text("Escapou!")
	yield(self, "textbox_closed")
	
	yield(get_tree().create_timer(0.25), "timeout")
	get_tree().change_scene("res://Cenas/Exploração/Mapa.tscn")


func _on_Ataque_pressed():
	display_text("Você balança a sua espada")
	yield(self, "textbox_closed")
	
	current_enemy_health = max(0, current_enemy_health - Estado.damage)
	set_health($Inimigo/ProgressBar, current_enemy_health, enemy.health) 
	
	$AnimationPlayer.play("inimigo_damaged")
	yield($AnimationPlayer, "animation_finished")
	
	display_text("Você causou %d de dano" %Estado.damage)
	yield(self, "textbox_closed")
	
	if current_enemy_health == 0:
		display_text("%s foi derrotado!" % enemy.name) 
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("inimigo_morreu")
		yield($AnimationPlayer, "animation_finished")
		
		yield(get_tree().create_timer(0.25), "timeout")
		get_tree().change_scene("res://Cenas/Exploração/Mapa.tscn")
		
		
		
	enemy_turn()

func _on_Defender_pressed():
	is_defending = true
	
	display_text("Você se prepara defensivamente")
	yield(self, "textbox_closed")
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	enemy_turn()
