extends Node

var player_name : String = 'avc'

func _init():
	print_debug('From Parent Init(), player name :', player_name)

func PMove(speed : float):
	print_debug('From Parent=====', player_name,' gogogo! speed: ', speed)
