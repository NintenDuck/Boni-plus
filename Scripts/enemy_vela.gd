extends "res://Scripts/parent_enemy.gd"

const fire_bullet = preload("res://Scenes/actors/enemies/bullet_enemy_fuego.tscn")

onready var attackCooldownTimer = $attackCooldown
onready var bulletInitPos = $bulletInitPos
onready var collision = $CollisionShape2D

var can_attack = false

#func _on_playerDetector_playerDetected(plyr):
#	player = plyr
#	playerDetected = true
#	attackCooldownTimer.start()


# warning-ignore:unused_argument
func _process(delta):
	if playerDetected:
		collision.disabled = true
#		print(attackCooldownTimer.time_left)
		if attackCooldownTimer.time_left == 0:
			shoot()
			attackCooldownTimer.start()
	
func shoot():
	Sfx.Play("enemy_bullet")
	var bullet = Utils.instance_to_main( fire_bullet, bulletInitPos.global_position )
	bullet.look_at(player.global_position)
	bullet.speed = 15
	bullet.velocity = Vector2.RIGHT.rotated(bullet.rotation) * bullet.speed


func _on_playerDetector_playerDetected(plyr):
	player = plyr
	playerDetected = true
	attackCooldownTimer.start()
