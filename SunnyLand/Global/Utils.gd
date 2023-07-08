# 该脚本创建后为挂载在任何节点上，在项目设置-自动加载中设置了启用

extends Node


const SAVE_PATH = "res://savegame.bin"

# 存档
func saveGame():
	# 以加密形式打开文件
	var file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, 'password')
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.Gold,
	}
	var jstr = JSON.stringify(data)
	# 加密写入
	file.store_var(jstr)

# 读档
func loadGame():
	# 以加密形式打开文件
	var file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, 'password')
	# 判断文件是否已存在
	if FileAccess.file_exists(SAVE_PATH) == true :
		#if not file.eof_reached() :
		print_debug(file.get_length())
		# 读取全部内容参考file.eof_reached()方法的说明
		while file.get_position() < file.get_length():
			
			print_debug(typeof(file.get_position()))
			# get_var() 解密读出内容
			var current_line = JSON.parse_string(file.get_var())
			if current_line :
				Game.playerHP = current_line['playerHP']
				Game.Gold = current_line['playerGold']
