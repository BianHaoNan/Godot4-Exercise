extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#var health = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer
@onready var spritePlayer = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY	
		anim.play("PlayerAnim/Jump_Up")
	# 开始下落时，velocity.y变为正值
	if velocity.y > 0 :
		anim.play("PlayerAnim/Jump_Fall")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		#print_debug('direction:' + str(direction))
		if velocity.y == 0 :
			spritePlayer.flip_h = direction < 0
			anim.play("PlayerAnim/Run")
	else:
		if velocity.y == 0 :
			anim.play("PlayerAnim/Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# hp归零后返回主页
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Main.tscn")
