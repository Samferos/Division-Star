extends Position2D

func _on_DeathZone_body_exited(body):
	body.position = position
