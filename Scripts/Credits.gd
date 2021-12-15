extends Node


func _ready():
	pass


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	Music.stop()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/levels/Title_Screen.tscn")
