extends Node

# 游戏内呼出系统菜单
@onready var sys_menu_scene = preload("res://Scenes/Menus/SystemMenu.tscn")
var sys_menu_statu = false
var sys_menu

# 当前场景是否允许打开系统菜单
var statu_current_scene = false

func _ready():
	sys_menu = sys_menu_scene.instantiate()
	

func _process(delta):
	if Input.is_action_just_pressed('call_sys_menu') and statu_current_scene:
		SysMenuSwitch()

func SysMenuSwitch():
		if !sys_menu_statu:
			get_node("/root/Chapter_000").add_child(sys_menu)
			print_debug('call me')
			sys_menu_statu = true
		else :
			print_debug('close me')
			get_node("/root/Chapter_000").remove_child(sys_menu)
			sys_menu_statu = false
