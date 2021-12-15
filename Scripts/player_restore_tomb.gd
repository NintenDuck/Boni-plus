extends "res://Scripts/parent_enemy.gd"

const bread = preload("res://Scenes/actors/player/Item_bread.tscn")

func _exit_tree():
	if enemyStats.health == 0:
		spawn_bread()
	
func spawn_bread():
	Utils.instance_to_main( bread, global_position)
	pass
