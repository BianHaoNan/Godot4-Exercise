extends PScript

func _ready():
	#CMove()
	PMove(7.0)
	

func _physics_process(delta):
	#PMove(7.0)
	pass

func CMove():
	PMove(5.0)
	
func _init():
	player_name = 'Barbala'
	print_debug("From Child Init()")
	print_debug('from child ,print p player_name : ', PScript.player_name)
