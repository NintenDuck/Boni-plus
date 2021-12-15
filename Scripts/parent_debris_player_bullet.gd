extends "res://Scripts/parent_debris.gd"

var total_animation_frames = 0


func _ready():
	randomize()
	total_animation_frames = $Sprite.hframes
#	print(total_animation_frames)
	sprite.frame = randi() % total_animation_frames
