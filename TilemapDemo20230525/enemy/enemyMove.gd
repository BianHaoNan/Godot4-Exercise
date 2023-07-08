extends CharacterBody2D

@export var speed = 20
var target = null
var chase = false

func _physics_process(delta):
	if chase :
		position += (target.position - position) / speed
		$AnimatedSprite2D.play("run")
		if(target.position.x - position.x) < 0 :
			$AnimatedSprite2D.flip_h = true
		else :
			$AnimatedSprite2D.flip_h = false
	else :
		$AnimatedSprite2D.play("idle")

func _on_area_2d_body_entered(body):
	print('1212121')
	target = body
	chase = true


func _on_area_2d_body_exited(body):
	print('44444')
	target = null
	chase = false
	
	
