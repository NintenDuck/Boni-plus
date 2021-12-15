extends Area2D

export var velocity = Vector2.ZERO
export var speed = 0
export var direction = 1
export var rotates = false
export var turn_speed = 1
onready var sprite = $Sprite

func _physics_process(delta):
	position += (velocity*direction) * delta
	sprite.scale.x = 1
	if rotates:
		sprite.rotation += turn_speed


# warning-ignore:unused_argument
func _on_parent_bullet_body_entered(body):
	queue_free()


# warning-ignore:unused_argument
func _on_Hitbox_area_entered(area):
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
