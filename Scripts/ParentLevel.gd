extends Node2D

#signal newCameraLimits(tlLimit, brLimit)
onready var NO_limits = $Positions/NO_limit_position.global_position
onready var SE_limits = $Positions/SE_limit_position.global_position
onready var playerInitPos = $Positions/player_init_position.global_position

export var final_level = false

export var play_music = false
export var stop_music = false
export(String) var songName = ""

var top_left_limit = Vector2.ZERO
var bottom_right_limit = Vector2.ZERO
var test_variable = Vector2(20,20)

func _ready():
	change_camera_limits()
	set_new_checkpoint()
	if play_music == true:
		Music.Play(songName)
	if stop_music == true:
		Music.stop()

func set_new_checkpoint():
	var parent = get_parent()
	parent.currentCheckpoint = self
	print("Checkpoint: " + parent.currentCheckpoint.name)
	
	
func change_camera_limits():
	top_left_limit = NO_limits
	bottom_right_limit = SE_limits
#	print("top_left: " + str(top_left_limit))
#	print("bottom_right: " + str(bottom_right_limit))
#	emit_signal( "newCameraLimits", top_left_limit, bottom_right_limit )
