extends CharacterBody2D

# 移动速度
@export var speed = 100

func _physics_process(delta) :
	move(delta)


func move(t) :
	# 通过get_axis可获得按键力度，手柄应该可用
	var directionX := Input.get_axis("left","right")
	var directionY := Input.get_axis("up","down")
	
	# 先判断移动按键是否为上左、上右、下左、下右的组合，如果是，则指定播放动画
	if Input.is_action_pressed("up") && Input.is_action_pressed("left") :
		$AnimatedSprite2D.play("run_up")
	elif Input.is_action_pressed("up") && Input.is_action_pressed("right") :
		$AnimatedSprite2D.play("run_up")
	elif Input.is_action_pressed("down") && Input.is_action_pressed("left") :
		$AnimatedSprite2D.play("run_down")
	elif Input.is_action_pressed("down") && Input.is_action_pressed("right") :
		$AnimatedSprite2D.play("run_down")
	else :
		# 再判断移动按键是否为上下的组合，如果是，则指定播放动画，如果不是，则进行单个按键的判断
		if ! (Input.is_action_pressed("up") && Input.is_action_pressed("down")) :
			if Input.is_action_pressed("up") :
				$AnimatedSprite2D.play("run_up")
			elif Input.is_action_just_released("up") :
				$AnimatedSprite2D.play("idle_up")
			if Input.is_action_pressed("down") :
				$AnimatedSprite2D.play("run_down")
			elif Input.is_action_just_released("down") :
				$AnimatedSprite2D.play("idle_down")
		else :
			$AnimatedSprite2D.play("idle_down")
		# 再判断移动按键是否为左右的组合，如果是，则指定播放动画，如果不是，则进行单个按键的判断
		if ! (Input.is_action_pressed("left") && Input.is_action_pressed("right")) :
			if Input.is_action_pressed("right") :
				$AnimatedSprite2D.play("run")
			elif Input.is_action_just_released("right") :
				$AnimatedSprite2D.play("idle")
			if Input.is_action_pressed("left") :
				$AnimatedSprite2D.play("run")
			elif Input.is_action_just_released("left") :
				$AnimatedSprite2D.play("idle")
		else :
			$AnimatedSprite2D.play("idle")
	
	# 水平方向的移动，水平反转即可再利用同一个动画
	$AnimatedSprite2D.flip_h = directionX < 0
	velocity.x = directionX
	velocity.y = directionY
	# 因为需要按键力度来控制速度，所以不需要求单位向量
	# position += velocity.normalized() * t * speed
	position += velocity * t * speed
