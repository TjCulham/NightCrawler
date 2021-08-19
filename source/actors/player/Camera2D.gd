extends Camera2D



func _on_player_groundedUpdated(isGrounded) -> void:
	drag_margin_v_enabled != isGrounded
