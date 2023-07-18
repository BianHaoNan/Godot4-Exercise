extends Node

@onready var sys_menu_scene = preload("res://Scenes/Menus/SystemMenu.tscn")
@onready var sys_menu = sys_menu_scene.instantiate()

func _process(delta):
	# 如果按下esc，并且当前场景允许打开系统菜单，才会打开菜单
	if Input.is_action_just_pressed('call_sys_menu'):
		#print_debug('pressed is call sys menu?')
		CallSystemMenu.sys_menu = sys_menu
		CallSystemMenu.SysMenuSwitch()
	'''
	if Input.is_action_just_released("call_sys_menu"):
		print_debug('released is call sys menu?')
		CallSystemMenu.sys_menu = sys_menu
		CallSystemMenu.SysMenuSwitch()
	'''
