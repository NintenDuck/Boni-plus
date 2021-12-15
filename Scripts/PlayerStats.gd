extends Node

onready var player = get_parent()

export var max_health = 2
export var max_bones = 2

var health = max_health setget set_health
var bones_left = max_bones setget set_bones

func _ready():
	bones_left = bones_left
#	player.shader.set("shader_param/hit_color", 0)
func set_health(value):
	health = clamp( value, 0, max_health )
	if health == 1:
		player.shader.set("shader_param/hit_strength", 1)
	else:
		player.shader.set("shader_param/hit_strength", 0.1)
	print("Current health: " + str(health))
#	print("Current Health: " + str(health))
	if health == 0:
		player.emit_signal("player_died")

func set_bones(value):
	bones_left = clamp(value, 0, max_bones)
#	print("Current bones: " + str(bones_left))
	pass
