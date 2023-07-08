extends TileMap

var height_map_id
var custom_data
var c : CharacterBody2D
var body_enter_pos_y
var body_exit_pos_y
'''
利用Custom Data来做地图高低效果，需要不停检索角色所在位置地图块的信息，匹配上信息后，通过修改角色的Collision Layer和Collision Mask的值来控制角色和地图块的碰撞关系
不适合修改地图块属性，每帧遍历会非常占资源
适合不用从穿过上层或下层地图的时候使用，因为Custom Data地图块要铺在碰撞的周围和上面，所以在穿过地图时，会把正在穿过的那层地图该有的碰撞关系都给取消掉。
'''
func _ready():
	# 遍历Layers中的所有层级，获得层级id
	for i in get_layers_count():
		#print_debug(get_layer_name(i))
		# 根据层级id获得层级name，匹配名称
		if get_layer_name(i) == 'HightLayer':
			height_map_id = i
func _process(delta):
	# 获取Layer层中某个位置的地图块的TileSet信息
	custom_data = get_cell_tile_data(height_map_id, local_to_map(c.global_position))
	#custom_data = get_cell_tile_data(height_map_id, local_to_map(get_local_mouse_position()))
	if custom_data != null:
		# 获取TileSet信息中，对应name的CustomDataLayers的信息
		if custom_data.get_custom_data('Ladder'):
			# 修改角色的碰撞属性
			c.set_collision_layer_value(1, false)
			c.set_collision_mask_value(1, false)
	else :
		c.set_collision_layer_value(1, true)
		c.set_collision_mask_value(1, true)
'''
Area2D来做地图高低效果，获得进出Area2D的位置，来判断下一步做何操作。通过修改地图的某个Physical Layers的值来控制地图块与角色之间的碰撞关系，通过修改某个层级的地图的y sort origin值来控制地图块与玩家的前后关系。
set_physics_layer_collision_layer()和set_layer_y_sort_origin()在修改地图属性的时候，要注意周围使用了相同物理层、地图层的同类型的地图块，在这些不需要修改的地图块上可以加一层透明的其他层级的带碰撞的地图块。
地图块的碰撞不要画的花里胡哨的，一是操作起来被各种歪七八扭的地形拦住很不舒服，二是不规则的碰撞配上这两种做地图高低效果的方法非常容易卡在某个奇葩的碰撞角落里
如果是有进出口的地形，在进出口都要安排上Area2D
注意角色通过Area2D的方向，左右、上下
'''
# 进口Area2D
func _on_area_2d_body_exited(body):
	if body.name == c.name:
		body_exit_pos_y = body.global_position.y
		for i in get_layers_count():
			if get_layer_name(i) == 'Mountains':
				# 从下面进来，上面出去
				if body_exit_pos_y < body_enter_pos_y:
					# 使玩家与地图块失去碰撞关系，并将地图块的显示层级放在玩家之上
					tile_set.set_physics_layer_collision_layer(0, 10)
					set_layer_y_sort_origin(i, 32)
				# 从上面进来，下面出去
				elif body_exit_pos_y > body_enter_pos_y:
					# 使玩家与地图块建立碰撞关系，并将地图块的显示层级放在玩家之下
					tile_set.set_physics_layer_collision_layer(0, 1)
					set_layer_y_sort_origin(i, -32)

func _on_area_2d_body_entered(body):
	body_enter_pos_y = body.position.y

# 出口Area2D
func _on_area_2d_2_body_entered(body):
	body_enter_pos_y = body.position.y

func _on_area_2d_2_body_exited(body):
	if body.name == c.name:
		body_exit_pos_y = body.global_position.y
		for i in get_layers_count():
			if get_layer_name(i) == 'Mountains':
				# 从上面进来，下面出去
				if body_exit_pos_y > body_enter_pos_y:
					# 使玩家与地图块失去碰撞关系，并将地图块的显示层级放在玩家之上
					tile_set.set_physics_layer_collision_layer(0, 10)
					set_layer_y_sort_origin(i, 32)
				# 从下面进来，上面出去
				elif body_exit_pos_y < body_enter_pos_y:
					# 使玩家与地图块建立碰撞关系，并将地图块的显示层级放在玩家之下
					tile_set.set_physics_layer_collision_layer(0, 1)
					set_layer_y_sort_origin(i, -32)
