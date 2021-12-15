extends Node2D

onready var levelTransitionAnimator = $UI/LevelTransition/AnimationPlayer

var plyr = null

func _ready():
	levelTransitionAnimator.play("fade_in")
#	print(plyr.name)


# warning-ignore:unused_argument
func _on_playerDetector_body_entered(player):
	go_to_main_game(player)

func go_to_main_game(player):
	player.currentState = player.state.changing_level
	levelTransitionAnimator.play("fade_out")
	yield(levelTransitionAnimator,"animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/levels/World.tscn")
	pass
