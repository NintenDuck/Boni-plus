extends "res://Scripts/parent_enemy.gd"

onready var floorDetector = $Sprite/floorDetector

#var direction = 1
#var motion = Vector2.ZERO


func _process(delta):
	
	if not floorDetector.is_colliding():
		direction *= -1
#		print(direction)
		sprite.scale.x = direction
		
	
	position.x += (velocity * direction) * delta
#	motion.x += velocity * direction
#	motion.x = min(0,)
#	motion = move_and_slide( motion, Vector2.UP)
	pass



#func _on_Hurtbox_hit(damage):
#	Sfx.Play("enemy_damage",-10)
#	enemyStats.health -= damage
