extends Sprite2D

# 移动速度
@export var speed = 100


func _physics_process(delta) :
	move(delta)

func move(t) :
	# 通过get_axis可获得按键力度，手柄应该可用
	var directionX := Input.get_axis("left","right")
	var directionY := Input.get_axis("up","down")
	
	var vel = Vector2.ZERO
	vel.x += directionX
	vel.y += directionY
	if vel.length() < 0 :
		return
	position += vel.normalized() * speed * t
	
