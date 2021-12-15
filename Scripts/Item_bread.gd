extends Area2D

const item_debris = preload("res://Scenes/actors/player/debris_player_enemy_hit.tscn")
func _on_Item_bread_body_entered(player):
	Sfx.Play("player_bread",10)
	player.restore_health(1)
	Utils.instance_to_main( item_debris, global_position )
	queue_free()
