extends Area2D

export(String,FILE) var nextLevel

onready var newPlayerPosition = get_parent().playerInitPos

func _on_nextLevelArea_body_entered(plyr):
	plyr.emit_signal("hit_next_level_door", self)
