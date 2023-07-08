extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 节点退出屏幕时，发出该信号，销毁节点
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
