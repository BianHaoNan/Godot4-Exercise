extends CanvasLayer



var bus_id: int

@onready var buttonSound = $ButtionSound
@onready var buttonSound2 = $ButtionSound2

@onready var volumeSet = $Volume
@onready var screenSizeSet = $ScreenSize

@onready var masterHSlider = $Volume/MasterVolume/MasterHSlider
@onready var mvHSlider = $Volume/MusicVolume/MVHSlider
@onready var bvHSlider = $Volume/ButtonVolume/BVHSlider
@onready var sfxHSlider = $Volume/SFXVolume/SFXVHSlider

@onready var screenSizeItemList = $ScreenSize/ScreenSizeItemList

@onready var windowMode1 = $ScreenSize/WindowModeContainer/WindowedCheckButton
@onready var windowMode2 = $ScreenSize/WindowModeContainer/FullScreenCheckButton
@onready var windowMode3 = $ScreenSize/WindowModeContainer/ExclusiveFullScreenCheckButton

func _ready():
	#print_debug(get_tree().root.size)
	#print_debug(get_tree().root.position)
	screenSizeSet.hide()
	
	if !Saving.LoadConfig():
		# 默认屏幕大小选择0
		screenSizeItemList.select(0)
		# 默认屏幕显示模式选项为窗口化
		windowMode1.set_pressed_no_signal(true)
		#print_debug(windowMode1.button_group)
	else:
		# 读取存档中的音量大小，直接应用，set_value()设置方法可以直接触发按钮信号
		masterHSlider.set_value(Saving.master_vol)
		mvHSlider.set_value(Saving.bgm_vol)
		bvHSlider.set_value(Saving.btnSound_vol)
		sfxHSlider.set_value(Saving.sfx_vol)
		#print_debug(Saving.screen_mode)
		# 读取存档中的屏幕模式、屏幕大小，直接应用
		match Saving.screen_mode:
			0:
				# set_pressed()的设置方法可以直接触发按钮信号
				windowMode1.set_pressed(true)
				# 由于全屏、独占全屏模式不需要设置窗口大小，所以只在窗口化时修改屏幕大小
				screenSizeItemList.select(Saving.screen_size)
				_on_screen_size_item_list_item_selected(Saving.screen_size)
			1:
				windowMode2.set_pressed(true)
			2:
				windowMode3.set_pressed(true)

# 设置菜单的关闭按钮
func _on_button_pressed():
	buttonSound.play()
	hide()

# 特效音量
func _on_sfxvh_slider_value_changed(value):
	SetVolume('SFX', value)

# 按钮音量
func _on_bvh_slider_value_changed(value):
	SetVolume('BtnSound', value)

# BGM音量
func _on_mvh_slider_value_changed(value):
	SetVolume('BGM', value)
	
# 总音量
func _on_master_h_slider_value_changed(value):
	SetVolume('Master', value)

# 设置音量
func SetVolume(bus_name, value):
	#print_debug(value)
	#print_debug(linear_to_db(value))
	# 获取音量值
	#print_debug(db_to_linear(AudioServer.get_bus_volume_db(bus_id)))
	#print('-+----+-+-+')
	#print_debug(AudioServer.bus_count)
	#print_debug(bus_id)
	#AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
	bus_id = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_id,linear_to_db(value))
	# 游戏启动2000ms后，才会启动设置内的按钮音效。（读存档初始化时，按钮音响会播放，没想到太好的解决办法）
	if Time.get_ticks_msec() > 2000:
		buttonSound2.play()
	match bus_name:
		'Master':
			Saving.master_vol = value
		'BGM':
			Saving.bgm_vol = value
		'BtnSound':
			Saving.btnSound_vol = value
		'SFX':
			Saving.sfx_vol = value
	Saving.SaveConfig()

# 音量设置内容显示
func _on_volume_set_pressed():
	volumeSet.show()
	screenSizeSet.hide()
	buttonSound.play()

# 屏幕设置内容显示
func _on_screen_size_set_pressed():
	volumeSet.hide()
	screenSizeSet.show()
	buttonSound.play()



# 屏幕大小设置选单
func _on_screen_size_item_list_item_selected(index):
	#print_debug(index)
	match index:
		0:
			SetScreenSize(Vector2i(1920, 1080))
		1:
			SetScreenSize(Vector2i(1280, 720))
		2:
			SetScreenSize(Vector2i(2560, 1440))
	#print_debug('设置窗口大小 index:', index, ', time:', Time.get_time_string_from_system())
	
	Saving.screen_size = index
	Saving.SaveConfig()

# 设置屏幕大小，并重置窗口位置
func SetScreenSize(sizeValue):
	var r = get_tree().root
	r.set_size(sizeValue)
	r.position = Vector2i(10, 50)
	if Time.get_ticks_msec() > 2000:
		buttonSound2.play()

# 屏幕状态选项
func _on_check_button_toggled(button_pressed, extra_arg_0, extra_arg_1):
	'''print('-*-*-*-*-*-*-*-')
	print_debug(button_pressed)
	print_debug(extra_arg_0)
	print_debug(extra_arg_1)
	print('-*-*-*-*-*-*-*-')'''
	match extra_arg_0:
		0:
			SetScreenMode(0, button_pressed)
		1:
			SetScreenMode(3, button_pressed)
		2:
			SetScreenMode(4, button_pressed)
	#print_debug('设置窗口模式 extra_arg_0:', extra_arg_0, ', time:', Time.get_time_string_from_system())
	Saving.screen_mode = extra_arg_0
	Saving.SaveConfig()

# 设置窗口模式
func SetScreenMode(modeID, button_pressed):
	get_tree().root.mode = modeID
	# check_box被设置为单选模式后，选择其他选项，原本被选择的那一项相当于又被点击一次，还是会触发信号，导致会有两次音效响起
	if Time.get_ticks_msec() > 2000 and button_pressed:
		buttonSound2.play()
	# 如果是全屏、独占全屏，则禁用窗口大小功能
	if modeID != 0:
		for i in range(3):
			screenSizeItemList.set_item_disabled(i, true)
	else :
		for i in range(3):
			screenSizeItemList.set_item_disabled(i, false)
		# 设置选中值
		if Saving.LoadConfig():
			screenSizeItemList.select(Saving.screen_size)
		else :
			screenSizeItemList.select(0)
	print('*--*-*-*-*-*-*-*')
	for i in range(3):
		# item的disabled属性竟然没用，不管代码还是属性面板里改变状态，item显示上的状态变了，但点击功能仍然生效
		print_debug(screenSizeItemList.is_item_disabled(i))
	print('*--*-*-*-*-*-*-*')
