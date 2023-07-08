extends Node


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


func LoadConfig():
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


func SaveGame_Player():
	pass

func LoadGame_Player():
	pass
