extends Node2D

export var velocity = Vector2.ZERO
export var max_velocity = Vector2.ZERO
export var desacceleration = 0.0
export var static_debris = false
export var random_debris = false
export var max_trail = Vector2.ZERO

onready var clearTimer = $clear_timer
onready var sprite = $Sprite

func _ready():
	if static_debris == false:
		if random_debris:
			velocity = Vector2(rand_range(-max_velocity.x,max_velocity.x),rand_range(-max_velocity.y, max_velocity.y))
	else:
		clearTimer.start()

func _process(delta):
	if static_debris == false:
#		print(velocity)
		position += velocity * delta
		velocity = Vector2( lerp( velocity.x, 0, desacceleration), lerp(velocity.y, 0, desacceleration ) )
		if velocity <= max_trail:
			queue_free()
	else:
#		print(clearTimer.time_left)
		if clearTimer.time_left == 0:
			queue_free()
