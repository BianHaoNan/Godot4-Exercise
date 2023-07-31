extends Camera2D




func _process(delta):
	
	# 呼出和关闭游戏内菜单时，能够调整镜头大小
	if Input.is_action_just_pressed("call_sys_menu"):
		if CallSystemMenu.sys_menu_statu:
			zoom = Vector2(1, 1)
		else :
			zoom = Vector2(2, 2)
