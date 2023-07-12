extends Move

@onready var body = $"."
@onready var anim = $AnimatedSprite2D

func _init():
	level = 1
	hp = 5

func _physics_process(delta):
	Move(100.0, body, anim)
