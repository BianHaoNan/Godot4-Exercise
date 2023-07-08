extends Sprite2D


@export var RotSpeed = 1.0
@export var ScaleSpeed = 1.0

func _ready():
	print_debug("Geormetry Incubation")

func _process(delta):
	rotate(0.01 * RotSpeed)
	scale -= (Vector2(0.01,0.01) * ScaleSpeed)
	#print_debug(scale)
	if scale.x < 0.9:
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_area_2d_body_entered(body):
	body.queue_free()
