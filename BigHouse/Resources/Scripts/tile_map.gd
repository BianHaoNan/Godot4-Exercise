extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	$player.start($Marker2D.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
