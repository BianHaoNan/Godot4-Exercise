extends Node2D

var Geometry = preload("res://Scenes/GeormetryIncubation.tscn")
var Player = preload("res://Scenes/Player.tscn")

func _ready():
	var player = Player.instantiate()
	player.position = $Marker2D.position
	add_child(player)

func _on_timer_timeout():
	print_debug("timer go")
	var g = Geometry.instantiate()
	g.position = Vector2(960, 540)
	add_child(g)
