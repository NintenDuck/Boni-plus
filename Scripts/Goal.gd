extends Area2D

onready var animator = $AnimationPlayer

var active = true

# warning-ignore:unused_argument
func _on_playerDetector_body_entered(player):
	if active:
		Sfx.Play("flag_sfx")
		animator.play("high")
		active = false
