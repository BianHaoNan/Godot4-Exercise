extends Node2D


func _ready():
	# 判断存档中hp是否大于0，小于的话先重置并保存，然后才能开启游戏，大于0的话直接读档
	if Game.playerHP <= 0 :
		Game.playerHP = 10
		Game.Gold = 0
		Utils.saveGame()
	else :
		Utils.loadGame()
	

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	#print_debug(Game.playerHP)
	get_tree().change_scene_to_file("res://World.tscn")
