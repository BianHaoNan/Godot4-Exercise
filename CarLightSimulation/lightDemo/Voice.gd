extends Node2D

@onready var t = $Timer
@onready var wrongVoice = $Wrong


var examTaking := false
var q = []
var randQuestion = []
var isRight := true
var ttt = 0
# 第三题5随1
var j = 3
# 第七题2随1
var k = 11

func _ready():
	var lightSystem = load("res://lightDemo/Lamp.gd")
	var lightScript = lightSystem.new()

func _on_start_pressed():
	$Dong.play()
	$"../UI/Start".hide()
	examTaking = true
	ttt = 0
	q.clear()
	
	q.append($OpenLowBeam)
	q.append($FollowingCar)
	
	# 第三题5随1
	j = randi_range(3,7)
	print_debug('j:'+ str(j))
	if j == 3:
		q.append($ThroughTheSharpBend)
	elif j == 4:
		q.append($ThroughTheSlope)
	elif j == 5:
		q.append($ThroughTheArchBridge)
	elif j == 6:
		q.append($ThroughTheCrosswalk)
	elif j == 7:
		q.append($IntersectionsNotControlledByTrafficLights)
	
	q.append($MeetingWithOtherCar)
	q.append($IntersectionsControlledByTrafficLights)
	q.append($Overtaking)

	# 第七题2随1
	k = randi_range(11,12)
	print_debug('k:'+ str(k))
	if k == 11:
		q.append($InPoorlyLitRoad)
	elif k == 12:
		q.append($OnUnlitRoads)
	
	q.append($"OnWell-litRoads")
	q.append($TemporaryParking)
	q.append($TurnOffAllLights)
	
	print('------------')
	print_debug(q)
	print_debug(q.back())
	print_debug(Vector2(3,4).length())
	
	print('------------')
	
	t.start()
	
func askQuestion():
	if ttt == 0:
		q[0].play()
		
		randQuestion.append(ttt)
	if ttt > 0 and ttt < 8:
		var i = 0
		while randQuestion.has(i):
			i = randi_range(1,7)
		randQuestion.append(i)
		print_debug('Q[i]:'+ str(i))
		q[i].play()
	if ttt == 8:
		q[8].play()
	if ttt == 9:
		q[9].play()
		await q[9].finished
		print_debug("考试结束")
	
	
	t.start(10)
# 判断答案
func referee(qNo):
	match qNo:
		0:
			pass
		1:
			pass

func _on_timer_timeout():
	askQuestion()
	ttt += 1
	if ttt > 10:
		get_tree().quit()
