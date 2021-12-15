extends "res://Scripts/parent_bullet.gd"

onready var bulletHitDebris = preload("res://Scenes/actors/player/debris_player_enemy_hit.tscn")
onready var bulletDebris = preload("res://Scenes/actors/player/debris_player_bullet.tscn")

signal bone_destroyed

export var rotation_spd = 0.3

func _physics_process(delta):
	# Makes the bullet move and rotate
	position.x += (velocity.x*direction) * delta
	sprite.rotation += rotation_spd * direction

func spawn_debris():
	# Spawn debris to make more "impact"
	Utils.instance_to_main( bulletHitDebris, global_position )
	Utils.instance_to_main( bulletDebris, global_position )
func _exit_tree():
	spawn_debris()
	#Signal to tell the playerStats that the bone has been
	#destroyed and it can throw another one
	emit_signal("bone_destroyed")
	
