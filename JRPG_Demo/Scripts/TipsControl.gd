extends Control

# tips的动画效果是否开启
var tips_statu : bool = true
@onready var ani : AnimationPlayer = $BubbleAnimation
@onready var point : Panel = $Bubble/RedPoint

func _process(delta):
	#print_debug('tips_statu : ', tips_statu)
	if tips_statu:
		ani.play("TipsDrift")
		point.show()
	else :
		ani.play("RESET")
		point.hide()

func ChangeTipsStatu():
	tips_statu = false
