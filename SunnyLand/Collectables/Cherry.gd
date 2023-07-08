extends Area2D


func _on_body_entered(body):
	if body.name == "Player" :
		Game.Gold += 1
		Utils.saveGame()
		# 添加樱桃消失的效果
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		# 向上浮起
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		# 渐隐
		tween1.tween_property(self, "modulate:a", 0, 0.5)
		tween.tween_callback(queue_free)
		
