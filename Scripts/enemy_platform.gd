extends StaticBody2D

const worldBit = 1

onready var animation = $AnimationPlayer
onready var timeAliveTimer = $timeAliveTimer
onready var respawnTimer = $respawnTimer
onready var sprite = $Sprite

var stepped_once = false

# warning-ignore:unused_argument
func _on_playerDetector_playerDetected(plyr):
	if stepped_once == false:
		animation.play("temblando")
		Sfx.Play("enemy_bullet")
		timeAliveTimer.start()
		stepped_once = true

func _on_timeAlive_timeout():
	animation.play("destruyendose")
	Sfx.Play("enemy_damage")

func hide_platform():
	set_collision_layer_bit(worldBit,false)
	sprite.visible = false
	respawnTimer.start()
	
func respawn_platform():
	set_collision_layer_bit(worldBit,true)
	stepped_once = false
	animation.play("respawn")
#	print("Platform Respawned")
	
func _on_respawnTimer_timeout():
	respawn_platform()
