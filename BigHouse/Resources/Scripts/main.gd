extends Node

@export var changeScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	if changeScene != null:
		get_tree().change_scene_to_packed(changeScene)
