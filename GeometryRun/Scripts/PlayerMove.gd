extends CharacterBody2D

@export var speed = 200


func playerMove():
	velocity = Vector2()
	if Input.is_action_pressed('d'):
		velocity.x += 1
	if Input.is_action_pressed("a"):
		velocity.x -= 1
	if Input.is_action_pressed("s"):
		velocity.y += 1
	if Input.is_action_pressed('w'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	playerMove()
	move_and_slide()
