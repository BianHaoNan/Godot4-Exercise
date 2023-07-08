extends Sprite2D

# 移动速度
@export var speed = 100

# 车灯
@onready var frontLight = $SpritePointLight2D
@onready var frontLightShadow = $ShadowPointLight2D2
#@onready var lTurnLight = $"../LeftTurnSignal"
#@onready var rTurnLight = $"../RightTurnSignal"
@onready var lTurnLightAnimF = $"../LeftTurnSignalF/LeftTurnSignalAnim"
@onready var rTurnLightAnimF = $"../RightTurnSignalF/RightTurnSignalAnim"
@onready var lTurnLightAnimB = $"../LeftTurnSignalB/LeftTurnSignalAnim"
@onready var rTurnLightAnimB = $"../RightTurnSignalB/RightTurnSignalAnim"
@onready var lWidthLightAnimF = $"../WidthLF/WidthLFAnim"
@onready var rWidthLightAnimF = $"../WidthRF/WidthRFAnim"
@onready var lWidthLightAnimB = $"../WidthLB/WidthLBAnim"
@onready var rWidthLightAnimB = $"../WidthRB/WidthRBAnim"
# 灯光控制开关
# 近光灯
var lowBeamCon := false
# 远光灯
var highBeamCon := false
# 远光灯临时开关，按下开，抬起关
var highBeamTempCon := false
# 左转向灯
var lTurnLightCon := false
# 右转向灯
var rTurnLightCon := false
# 危险警示灯
var warningLightCon := false
# 示宽灯
var widthLightCon := false
# 全车开关
var allLightCon := false

func _physics_process(delta) :
	move(delta)
	lightControl()

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

func lowBeamSwitch():
	match lowBeamCon:
		false:
			frontLight.enabled = true
			frontLightShadow.enabled = true
			lowBeamCon = true
			allLightCon = true
		true:
			frontLight.enabled = false
			frontLightShadow.enabled = false
			lowBeamCon = false

func highBeamSwitch():
	match highBeamCon:
		false:
			frontLight.energy = 2
			frontLight.scale *= 2
			frontLightShadow.energy = 2
			frontLightShadow.scale *= 2
			highBeamCon = true
		true:
			frontLight.energy = 1
			frontLight.scale /= 2
			frontLightShadow.energy = 1
			frontLightShadow.scale /= 2
			highBeamCon = false

func lTurnLightSwitch():
	match lTurnLightCon:
		false:
			lTurnLightAnimF.play("shining")
			lTurnLightAnimB.play("shining")
			lTurnLightCon = true
			if rTurnLightCon:
				rTurnLightAnimF.stop()
				rTurnLightAnimB.stop()
				rTurnLightCon = false
		true:
			lTurnLightAnimF.stop()
			lTurnLightAnimB.stop()
			lTurnLightCon = false

func rTurnLightSwitch():
	match rTurnLightCon:
		false:
			rTurnLightAnimF.play("shining")
			rTurnLightAnimB.play("shining")
			rTurnLightCon = true
			if lTurnLightCon:
				lTurnLightAnimF.stop()
				lTurnLightAnimB.stop()
				lTurnLightCon = false
		true:
			rTurnLightAnimF.stop()
			rTurnLightAnimB.stop()
			rTurnLightCon = false

func warningLightSwitch():
	match warningLightCon:
		false:
			rTurnLightAnimF.play("shining")
			rTurnLightAnimB.play("shining")
			lTurnLightAnimF.play("shining")
			lTurnLightAnimB.play("shining")
			rTurnLightCon = true
			lTurnLightCon = true
			warningLightCon = true
		true:
			rTurnLightAnimF.stop()
			rTurnLightAnimB.stop()
			lTurnLightAnimF.stop()
			lTurnLightAnimB.stop()
			rTurnLightCon = false
			lTurnLightCon = false
			warningLightCon = false

func widthLightSwitch():
	match widthLightCon:
		false:
			rWidthLightAnimF.play("RESET")
			rWidthLightAnimB.play("RESET")
			lWidthLightAnimF.play("RESET")
			lWidthLightAnimB.play("RESET")
			widthLightCon = true
			allLightCon = true
		true:
			rWidthLightAnimF.stop()
			rWidthLightAnimB.stop()
			lWidthLightAnimF.stop()
			lWidthLightAnimB.stop()
			widthLightCon = false

func lightControl():
	if Input.is_action_just_pressed("LowBeam") :
		if widthLightCon:
			widthLightSwitch()
		lowBeamSwitch()
	if Input.is_action_just_pressed("HighBeam") and lowBeamCon:
		highBeamSwitch()
	if Input.is_action_pressed("HighBeam_temporary") and lowBeamCon:
		if highBeamTempCon == false and highBeamCon == false:
			frontLight.energy = 2
			frontLight.scale *= 2
			frontLightShadow.energy = 2
			frontLightShadow.scale *= 2
			highBeamTempCon = true
	elif Input.is_action_just_released("HighBeam_temporary"):
		if highBeamTempCon == true and highBeamCon == false:
			frontLight.energy = 1
			frontLight.scale /= 2
			frontLightShadow.energy = 1
			frontLightShadow.scale /= 2
			highBeamTempCon = false
	if Input.is_action_just_pressed("LiftTurnSignal") and lowBeamCon:
		if warningLightCon:
			warningLightSwitch()
		lTurnLightSwitch()
	elif Input.is_action_just_pressed("RightTurnSignal") and lowBeamCon:
		if warningLightCon:
			warningLightSwitch()
		rTurnLightSwitch()
	if Input.is_action_just_pressed("WarningLight") :
		warningLightSwitch()
	if Input.is_action_just_pressed("TheWidthLight"):
		if lowBeamCon:
			lowBeamSwitch()
		widthLightSwitch()
	if Input.is_action_just_pressed("CloseAllLight"):
		if lowBeamCon:
			lowBeamSwitch()
		if widthLightCon:
			widthLightSwitch()
		if lTurnLightCon and !warningLightCon:
			lTurnLightSwitch()
		if rTurnLightCon and !warningLightCon:
			rTurnLightSwitch()
		allLightCon = false


