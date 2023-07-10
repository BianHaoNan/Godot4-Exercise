extends Control

@onready var button_sound : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_save_texture_button_pressed():
	button_sound.play()


func _on_reload_texture_button_pressed():
	button_sound.play()


func _on_settings_texture_button_pressed():
	button_sound.play()


func _on_return_main_menu_texture_button_pressed():
	button_sound.play()
	Loading.LoadGame(self, "res://Scenes/Blackground/Main.tscn")
	

func _on_save_and_exit_texture_button_pressed():
	button_sound.play()
	

func _on_close_texture_button_pressed():
	button_sound.play()
	await button_sound.finished
	CallSystemMenu.SysMenuSwitch()
