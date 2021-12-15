extends "res://Scripts/parent_enemy.gd"


# Kills the player on contact
func _on_playerDetector_playerDetected(plyr):
	plyr.player_stats.health -= 10
