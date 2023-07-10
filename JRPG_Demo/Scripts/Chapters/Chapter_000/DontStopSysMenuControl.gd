extends Node

func _process(delta):
	# 如果按下esc，并且当前场景允许打开系统菜单，才会打开菜单
	if Input.is_action_just_pressed('call_sys_menu'):
		print_debug('is call sys menu?')
		CallSystemMenu.SysMenuSwitch()
