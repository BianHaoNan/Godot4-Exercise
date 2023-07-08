extends Area2D

signal hit

@export var speed = 400	# how fast the player will move
var screen_size	# size of the game window
var player_height
var player_width	# size of the player

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player_height = $CollisionShape2D.shape.height
	player_width = $CollisionShape2D.shape.radius
	print('player_height: ' , player_height , ';player_width:' , player_width)
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO	#the player's movement vector
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, player_width, screen_size.x - player_width)
	position.y = clamp(position.y, player_height/2, screen_size.y - player_height/2)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = 'walk'
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0	# x方向的值小于0就反转，大于0就不反转
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = 'up'
		$AnimatedSprite2D.flip_v = velocity.y > 0

# 碰撞信号发生后，发出hit信号
func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)	# 碰撞发生后禁用碰撞

# 角色初始化
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false	# 启用碰撞
