extends Area2D

signal coin_collected

func _on_coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")
	set_collision_mask_bit(0,false)
	set_collision_layer_bit(3,false)
	



func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


