extends AnimatedSprite2D

@onready var tip : Control = $Tips
@onready var b : bool = false
signal c_tip

func _ready():
	# 将c_tip信号与Tips结点中的ChangeTipsStatu绑定
	self.connect('c_tip', Callable(tip, 'ChangeTipsStatu'))

func _process(delta):
	if b:
		if Input.is_action_just_pressed("interactive"):
			emit_signal('c_tip')
			play("cut_down2")

func _on_cut_down_area_body_entered(body):
	b = true

func _on_cut_down_area_body_exited(body):
	b = false
