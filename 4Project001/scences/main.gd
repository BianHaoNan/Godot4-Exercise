extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 接受player传来的hit信号后就停止分数、mob计数器
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()
	
	#get_tree().call_group('mobs', 'queue_free')
	
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	# 初始化分数、Message内容
	$HUD.update_score(score)
	$HUD.show_message('Get Ready')
	
	# 游戏开始后销毁所有存在的mob
	get_tree().call_group('mobs', 'queue_free')
	
	$Music.play()

# 分数计数器每次结束调用一次
func _on_score_timer_timeout():
	score += 1
	
	$HUD.update_score(score)

# StartTimer的OneShot属性设置为开启，倒计时结束后就会停止
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

# mob计数器每次结束，调用一次
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()	# 实例化mob
	
	# 设置mob诞生点在path2d运动路径上的偏移
	var mob_spaw_location = get_node('MobPath/MobSpawnLocation')
	mob_spaw_location.progress_ratio = randf()	# 获得一个随机的路径偏移量值
	
	# 设置mob诞生后的朝向与路线垂直，沿着path2d运动的物体朝向运动方向，所以只需要加90度
	var direction = mob_spaw_location.rotation + PI / 2	# godot用弧度计算，PI/2就是90度
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction	# 将随机后的朝向赋值给mob的rotation
	
	# 设置mob的初始位置等于mob诞生点位置
	mob.position = mob_spaw_location.position
	
	# 设置mob的速度、方向
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)	# 随机一个方向向量
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
