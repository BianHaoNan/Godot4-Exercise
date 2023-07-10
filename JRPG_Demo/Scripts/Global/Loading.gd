extends Node

@onready var loading_scene = preload("res://Scenes/Aisles/Loading.tscn")
var progressBar_value = []
var p_node
var p_node_2



func LoadGame(current_scene, next_scene):
	
	# 当前创景不可以打开系统菜单
	CallSystemMenu.statu_current_scene = false
	
	# 实例化loading场景，并将其添加进结点树
	var loading = loading_scene.instantiate()
	get_tree().root.call_deferred('add_child', loading)
	# 加载资源，如果成功则返回‘OK’，加载失败会返回报错
	var request_status = ResourceLoader.load_threaded_request(next_scene)
	
	# 找到当前场景的root节点下的第一个父结点，直接销毁（不能只删除当前结点）
	p_node = current_scene.get_parent()
	#print_debug('p node name :', p_node.name)
	#print_debug('current name :', current_scene.name)
	if p_node.name == 'root':
		current_scene.queue_free()
	else :
		while p_node.name != 'root':
			p_node_2 = p_node.get_parent()
			if p_node_2.name == 'root' or p_node_2 == null:
				break
			p_node = p_node_2
			#print_debug(p_node.name)
		p_node.queue_free()

	# loading界面可能会卡住，延迟0.5s等带loading界面显示
	#await get_tree().create_timer(0.5).timeout
	while true:
		# 获取加载状态，加入第二个参数可以获得加载进度的百分比值
		var load_status = ResourceLoader.load_threaded_get_status(next_scene, progressBar_value)
		#print_debug(load_status)
		# 获取未挂载本脚本的结点树中的某个节点
		var progressBar = loading.get_node('ProgressBar')
		# 给进度条赋值
		progressBar.value = progressBar_value[0] * 100
		#print_debug(progressBar_value[0] * 100)
		#print_debug(request_status)
		# 场景加载成功
		if load_status == 3:
			# 用于测试进度条显示是否正常
			await get_tree().create_timer(2).timeout
			# 跳转至场景
			var next = ResourceLoader.load_threaded_get(next_scene).instantiate()
			get_tree().root.call_deferred('add_child', next)
			loading.queue_free()
			return
