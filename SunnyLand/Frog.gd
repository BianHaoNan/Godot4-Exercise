extends CharacterBody2D

const SPEED = 50

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase := false

func _physics_process(delta):
	velocity.y += gravity * delta
	if chase:
		player = get_node("../../Player/Player")
		var d = (player.position - position).normalized()
		#print_debug(d)
		if d.x != 0 :
			$AnimatedSprite2D.flip_h = d.x > 0
			if $AnimatedSprite2D.animation != "Death" :
				$AnimatedSprite2D.play("Jump")
			velocity.x = d.x * SPEED
		else :
			print_debug("middle")
	else :
		velocity.x = 0
		if $AnimatedSprite2D.animation != "Death" :
			$AnimatedSprite2D.play("Idle")
	move_and_slide()

# 进入侦察范围，追踪玩家
func _on_player_detection_body_entered(body):
	if body.name == "Player" :
		chase = true

# 离开侦察范围，停止追踪
func _on_player_detection_body_exited(body):
	if body.name == "Player" :
		chase = false

# 进入可对敌人造成伤害的范围（头顶），敌人死亡
func _on_fog_death_body_entered(body):
	#print_debug(body.name)
	if body.name == "Player" :
		mobDeath()

# 进入敌人的伤害范围，对玩家造成伤害，敌人死亡
func _on_player_collision_body_entered(body):
	if body.name == "Player" :
		Game.playerHP -= 3
		mobDeath()

# 敌人只要碰到玩家，就要被消灭，敌人死亡时造成分数、金币变化，会进行存档
func mobDeath():
	Game.Gold += 1
	Utils.saveGame()
	
	chase = false
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()

