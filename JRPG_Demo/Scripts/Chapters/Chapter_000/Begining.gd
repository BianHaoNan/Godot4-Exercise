extends Node


var player_001_scene = preload("res://Scenes/Charactors/Player_001.tscn")
@onready var start_point : Marker2D = $StartPoint
@onready var tileMap : TileMap = $Chatper_000_TileMap_Woodland_Summer


func _ready():
	# 将玩家角色添加到当前创景的结点树中
	var player_001 = player_001_scene.instantiate()
	player_001.position = start_point.position
	add_child(player_001)
	# 将要使用的角色传给tileMap脚本
	tileMap.character_body = player_001
	# 当前创景可以打开系统菜单
	CallSystemMenu.statu_current_scene = true

