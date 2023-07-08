extends Area2D

@export var speed = 100
@onready var anim = $AnimatedSprite2D


func _process(delta):
	anim.play("idle")
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		anim.play()
	else :
		anim.play("idle")
	
	position += velocity * delta
	
	if velocity.x != 0 :
		anim.animation = 'run'
		anim.flip_v = false
		anim.flip_h = velocity.x < 0
	elif velocity.y !=0:
		anim.animation = 'idle'
		anim.flip_v = velocity.y > 0


func start(pos):
	position = pos
