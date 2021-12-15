extends Node

export var max_health = 1

var health = max_health setget set_health

func _ready():
	health = max_health
#	print("Init Max Health: " + str(max_health))
#	print("Init Health: " + str(health))
	
func set_health(value):
	health = clamp( value, 0, max_health )
#	print("Current health: " + str(health))
	if health <= 0:
		get_parent().queue_free()
