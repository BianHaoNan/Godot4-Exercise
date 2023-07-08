extends Node

@onready var buttonSound = $ButtonSound
@onready var settingMenu = $"../Settings"

var sound = preload("res://Resources/Mutilmedias/Audios/OneShotSmple/PL_80RP1_01_Kick_Sample.wav")

func _ready():
	buttonSound.stream = sound
	
	settingMenu.hide()
	
	
func _on_load_game_pressed():
	buttonSound.play()


func _on_new_game_pressed():
	buttonSound.play()
	Loading.LoadGame(self, "res://Scenes/Chapters/Chapter_000.tscn")

func _on_settings_pressed():
	buttonSound.play()
	settingMenu.show()

func _on_exit_pressed():
	buttonSound.play()
	get_tree().quit()

