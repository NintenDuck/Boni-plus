extends Area2D

signal playerDetected(plyr)

func _on_playerDetector_body_entered(plyr):
	emit_signal("playerDetected", plyr)
