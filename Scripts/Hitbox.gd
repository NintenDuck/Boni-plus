extends Area2D

export var damage = 1

func _on_Hitbox_area_entered( player ):
#	print("Hitbox collided with hurtbox")
	if get_parent().name == "bottomDeath":
		player.emit_signal("hit", 5)
	else:
		player.emit_signal( "hit", damage )
