extends "res://Scripts/parent_enemy.gd"

const bulletScene = preload("res://Scenes/actors/enemies/bullet_enemy_fuego.tscn")

enum states{
	idle,
	preparing,
	attacking
}

export(states) var current_state = states.idle

onready var attackDelayTimer = $attackDelay
onready var bulletInitPos = $Sprite/bulletInitPos

# warning-ignore:unused_argument
func _process(delta):
	match current_state:
		states.idle:
			animation.play("idle")
			if playerDetected:
				attackDelayTimer.start()
				
				change_state_to(states.preparing)
		states.preparing:
			direction = get_player_direction()
			update_direction()
			if attackDelayTimer.time_left == 0:
				change_state_to(states.attacking)
		states.attacking:
			animation.play("attack")

func change_state_to(new_state):
	current_state = new_state
#	match current_state:
#		states.idle:
#			print("IDLE")
#		states.preparing:
#			print("PREPARING TO ATTACK")
#		states.attacking:
#			print("ATTACKING")

func shoot():
	Sfx.Play("enemy_bullet")
	var bullet = Utils.instance_to_main( bulletScene, bulletInitPos.global_position )
	bullet.direction = direction
	bullet.velocity.x = 25

func _on_playerDetector_body_entered(plyr):
	player = plyr
	playerDetected = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		attackDelayTimer.start()
		change_state_to(states.preparing)
