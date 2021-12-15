extends "res://Scripts/parent_enemy.gd"

const calaveraHead = preload("res://Scenes/actors/enemies/bullet_enemy_calavera.tscn")

enum state{
	sleep,
	idle,
	throwing,
	running
}
onready var attackDelayTimer = $attackDelay
onready var playerDetectorCollision = $playerDetector/CollisionShape2D
onready var wallDetector = $Sprite/wallDetector
onready var floorDetector = $Sprite/floorDetector
onready var throwPosition = $Sprite/CalaveraPostiion

var current_state = state.sleep

func change_state_to(new_state):
	current_state = new_state
#	match current_state:
#		state.sleep:
#			print("SLEEP")
#		state.idle:
#			print("IDLE")
#		state.throwing:
#			print("THROWING")
#		state.running:
#			print("RUNNING")

# warning-ignore:unused_argument
func _physics_process(delta):
	match current_state:
		state.sleep:
			animation.play("sleep")
			if playerDetected:
				attackDelayTimer.start()
				change_state_to(state.idle)
		state.idle:
#			print(attackDelayTimer.time_left)
			direction = get_player_direction()
			update_direction()
			animation.play("idle")
			playerDetectorCollision.disabled = true
			if attackDelayTimer.time_left == 0:
				change_state_to(state.throwing)
		state.throwing:
			animation.play("throwing")
		state.running:
			check_for_floor_or_wall()
			run(delta)
			animation.play("running")

func run(delta):
	position.x += (velocity * direction) * delta
	
func throw_calavera():
#	print("Calavera lanzada")
	Sfx.Play("enemy_throw")
	var bullet = Utils.instance_to_main( calaveraHead, throwPosition.global_position)
	bullet.direction = direction
	
#	bullet.sprite.scale.x = direction

func start_running():
	change_state_to(state.running)

#func get_player_direction():
#	var player_direction
#	if player.global_position < global_position:
#		player_direction = -1
#	else:
#		player_direction = 1
#	return player_direction

func check_for_floor_or_wall():
	if not floorDetector.is_colliding() or wallDetector.is_colliding():
		direction *= -1
		update_direction()
func _on_playerDetector_playerDetected(plyr):
	player = plyr
	if player != null:
		playerDetected = true
