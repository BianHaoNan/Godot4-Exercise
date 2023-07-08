extends Node

var player_name : String

func _init():
	print_debug('From Parent Init()')

func PMove(speed : float):
	print_debug('From Parent=====', player_name,' gogogo! speed: ', speed)
	
