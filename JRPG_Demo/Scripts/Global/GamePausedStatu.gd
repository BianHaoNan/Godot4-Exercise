extends Node

var paused_statu : bool = false

func ChangePausedStatu():
	get_tree().paused = paused_statu
