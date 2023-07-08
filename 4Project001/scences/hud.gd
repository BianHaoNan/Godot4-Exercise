extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Message展示内容
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
# 游戏结束的后续表现
func show_game_over():
	show_message('Game Over')
	await $MessageTimer.timeout
	# MessageTimer计数结束后，将message展示的文字改为开始游戏提示
	$Message.text = 'Dodge the \nCreeps!'
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	# 1s后显示开始按钮
	$StartButton.show()
	
# 计分面板
func update_score(score):
	$ScoreLabel.text = str(score)
	
# MessageTimer计数器结束后隐藏Message信息
func _on_message_timer_timeout():
	$Message.hide()

# 按下开始按钮后，隐藏按钮，发送start_game信号
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
