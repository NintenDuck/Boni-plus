extends Node2D

onready var camera = $Camera2D
onready var UI = $UI
onready var levelTransitionAnimator = $UI/LevelTransition/AnimationPlayer
var currentLevel
var currentCheckpoint

var plyr = null

func _ready():
	levelTransitionAnimator.play("fade_in")
	currentLevel = $Level_01
	if currentLevel == $Level_01:
		move_player_to_new_init_position(currentLevel)
		limit_camera(currentLevel)
		currentCheckpoint = currentLevel
#		print("Checkpoint: " + currentCheckpoint.name)

func change_level_to(newLevelString, door_final_level):
	stop_player()
	fade_out()
	yield(levelTransitionAnimator,"animation_finished")
	if door_final_level == false:
		
		currentLevel.queue_free()
		var newLevelPath = load(newLevelString)
		var newLevelInstance = newLevelPath.instance()
		call_deferred("add_child", newLevelInstance)
		currentLevel = newLevelInstance
		yield(get_tree().create_timer(0.001),"timeout")
		
		limit_camera(currentLevel)
		move_player_to_new_init_position(currentLevel)
		fade_in()
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/levels/Credits.tscn")

func change_level_on_death():
#	print("Level changed on death")
	fade_out()
	yield(levelTransitionAnimator,"animation_finished")
	currentLevel.queue_free()
	var newLevelPath = load(currentCheckpoint.filename)
	var newLevelInstance = newLevelPath.instance()
	call_deferred("add_child",newLevelInstance)
	currentLevel = newLevelInstance
#	print("__________________________________________________________")
	yield(get_tree().create_timer(0.001),"timeout")
#	print("Current Level: " + currentLevel.name)
#	print("PInitPos of level: " + str(currentLevel.playerInitPos))
	move_player_to_new_init_position(currentLevel)
	restore_player_health()
	fade_in()
	yield(levelTransitionAnimator,"animation_finished")
	
func limit_camera(level):
	camera.limit_top = level.top_left_limit.y
	camera.limit_left = level.top_left_limit.x
	camera.limit_bottom = level.bottom_right_limit.y
	camera.limit_right = level.bottom_right_limit.x

func fade_in():
	levelTransitionAnimator.play("fade_in")
#	print("Fade in running")
	
func fade_out():
	levelTransitionAnimator.play("fade_out")
#	print("Fade out running")
	
func restore_player_health():
	plyr.restore_health(5)
	plyr.invinsible = false
func stop_player():
		plyr.currentState = plyr.state.changing_level
	
func move_player_to_new_init_position(level):
	if plyr != null:
		plyr.global_position = level.playerInitPos
		yield(get_tree().create_timer(1),"timeout")
		plyr.currentState = plyr.state.moving

func _on_player_hit_next_level_door(door):
	change_level_to(door.nextLevel,door.get_parent().final_level)


func _on_player_player_died():
	change_level_on_death()
