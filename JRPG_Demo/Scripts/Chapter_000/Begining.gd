extends Node


var player_001_scene = preload("res://Scenes/Charactors/Player_001.tscn")
@onready var start_point = $StartPoint
@onready var tileMap = $Chatper_000_TileMap_Woodland_Summer
func _ready():
	var player_001 = player_001_scene.instantiate()
	player_001.position = start_point.position
	add_child(player_001)
	tileMap.c = player_001
