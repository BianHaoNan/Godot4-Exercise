extends Node
class_name Move1
#var body : CharacterBody2D
func Move(speed : float, body : CharacterBody2D, ani : AnimatedSprite2D):
	# 通过get_axis可获得按键力度，手柄应该可用
	var directionX := Input.get_axis("left","right")
	var directionY := Input.get_axis("up","down")
	
	# 先判断移动按键是否为上左、上右、下左、下右的组合，如果是，则指定播放动画
	if Input.is_action_pressed("up") && Input.is_action_pressed("left") :
		ani.play("Walk_Up")
	elif Input.is_action_pressed("up") && Input.is_action_pressed("right") :
		ani.play("Walk_Up")
	elif Input.is_action_pressed("down") && Input.is_action_pressed("left") :
		ani.play("Walk_Down")
	elif Input.is_action_pressed("down") && Input.is_action_pressed("right") :
		ani.play("Walk_Down")
	else :
		# 再判断移动按键是否为上下的组合，如果是，则指定播放动画，如果不是，则进行单个按键的判断
		if ! (Input.is_action_pressed("up") && Input.is_action_pressed("down")) :
			if Input.is_action_pressed("up") :
				ani.play("Walk_Up")
			elif Input.is_action_just_released("up") :
				ani.play("Idle_UP")
			
			if Input.is_action_pressed("down") :
				ani.play("Walk_Down")
			elif Input.is_action_just_released("down") :
				ani.play("Idle_Dwon")
		else :
			ani.play("Idle_Dwon")
		# 再判断移动按键是否为左右的组合，如果是，则指定播放动画，如果不是，则进行单个按键的判断
		if ! (Input.is_action_pressed("left") && Input.is_action_pressed("right")) :
			if Input.is_action_pressed("right") :
				# 水平方向的移动，水平反转即可再利用同一个动画
				ani.flip_h = directionX <= 0
				ani.play("Walk_Right")
			elif Input.is_action_just_released("right") :
				ani.play("Idle_Right")
			
			if Input.is_action_pressed("left") :
				# 水平方向的移动，水平反转即可再利用同一个动画
				#ani.flip_h = directionX <= 0
				ani.play("Walk_Left")
			elif Input.is_action_just_released("left") :
				ani.play("Idle_Left")
		else :
			ani.play("Idle_Dwon")
	
	body.set_velocity(Vector2(directionX * speed, directionY * speed))
	
	body.move_and_slide()
