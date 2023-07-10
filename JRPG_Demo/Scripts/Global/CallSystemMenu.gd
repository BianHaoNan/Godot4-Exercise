extends Node

# 游戏内呼出系统菜单
@onready var sys_menu_scene = preload("res://Scenes/Menus/SystemMenu.tscn")
var sys_menu_statu = false
var sys_menu

var menu_position : Vector2 = Vector2(0, 0)

# 当前场景是否允许打开系统菜单
var statu_current_scene = false

func _ready():
	sys_menu = sys_menu_scene.instantiate()

func SysMenuSwitch():
	if statu_current_scene:
		if !sys_menu_statu:
			get_node("/root/Chapter_000").add_child(sys_menu)
			sys_menu.position = menu_position
			#print_debug('call me')
			sys_menu_statu = true
			# 打开菜单时暂停游戏
			GamePausedStatu.paused_statu = true
			GamePausedStatu.ChangePausedStatu()
		else :
			#print_debug('close me')
			get_node("/root/Chapter_000").remove_child(sys_menu)
			sys_menu_statu = false
			# 关闭菜单时取消暂停游戏
			GamePausedStatu.paused_statu = false
			GamePausedStatu.ChangePausedStatu()
