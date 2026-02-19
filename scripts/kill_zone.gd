extends Area2D

func _on_body_entered(_body):
	queue_free()
	get_tree().call_deferred("reload_current_scene")
	# preventing an error message about deleting Collision2D nodesn
