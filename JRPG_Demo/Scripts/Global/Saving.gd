extends Node

# 是否允许加载存档
var is_load_game : bool = true

# 存档文件的放置路径
const SAVE_CONFIG_FILE = 'res://SaveConfig.save'
const SAVE_GAME_FILE = 'res://SaveGame.save'

# 游戏设置信息，存档数据
var master_vol = 0.50
var bgm_vol = 0.50
var btnSound_vol = 0.50
var sfx_vol = 0.50
var screen_size : int = 0
var screen_mode : int = 0

# 游戏内容存档信息
# 存储场景信息时，应该不需要按场景保存，像存玩家角色一样，只需要存储该角色或者物体的状态、位置、所处场景即可
var character_name	# 哪个角色（玩家、npc、敌人）
var character_stay_scene	# 角色所处场景
var character_position : Vector2	# 角色所处位置
var character_statu_lv : int	# 角色等级
var character_statu_hp : int	# 角色血量
var character_item_list : Array	# 角色物品列表

'''# 每个场景个建立一个存档信息，存储当前场景中物体、npc、敌人的信息
var scenes_statu : Dictionary	# key是场景，value是场景内信息
var scenes_statu_value : Array	# scenes_statu的value值
var scene_objects_statu : Dictionary	# key是物体，value是物体状态
var scene_enemies_statu : Dictionary	# key是敌人，value是敌人状态
var scene_npc_statu : Dictionary	# key是npc，value是npc状态'''
var object_name
var object_stay_scene
var object_statu


# 游戏设置存档
func SaveConfig():
	# 打开文件
	var file = FileAccess.open(SAVE_CONFIG_FILE, FileAccess.WRITE)
	var data: Dictionary = {
		'master_vol': master_vol,
		'bgm_vol': bgm_vol,
		'btnSound_vol': btnSound_vol,
		'sfx_vol': sfx_vol,
		'screen_size': screen_size,
		'screen_mode': screen_mode
	}
	# 将内容写入文件
	file.store_line(JSON.stringify(data))

# 游戏设置读取存档
func LoadConfig():
	if is_load_game:
		var file = FileAccess.open(SAVE_CONFIG_FILE, FileAccess.READ)
		# 判断文件是否已存在
		if FileAccess.file_exists(SAVE_CONFIG_FILE):
			# 读取全部内容，参考file.eof_reached()方法的说明，解释虽然看不明白，但应该更保险吧
			while file.get_position() < file.get_length():
				var data = JSON.parse_string(file.get_line())
				# 加载数据
				master_vol = data['master_vol']
				bgm_vol = data['bgm_vol']
				btnSound_vol = data['btnSound_vol']
				sfx_vol = data['sfx_vol']
				screen_size = data['screen_size']
				screen_mode = data['screen_mode']
			return true
		else:
			return false

# 游戏内容存档
func SaveGame_Player():
	pass

# 游戏内容读取存档
func LoadGame_Player():
	pass
