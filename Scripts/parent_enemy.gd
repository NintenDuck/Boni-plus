extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var enemyStats = $EnemyStats
onready var sprite = $Sprite
export var velocity = 0

#enum directions{
#	LEFT = -1,
#	RIGHT = 1
#}

var player = null
var playerDetected = false
var direction = 1

func _ready():
	sprite.scale.x = direction

func get_player_direction():
	var player_direction
	if player.global_position < global_position:
		player_direction = -1
	else:
		player_direction = 1
	return player_direction
	
func update_direction():
	sprite.scale.x = direction
	
func _on_Hurtbox_hit(damage):
	Sfx.Play("enemy_damage",-5)
	enemyStats.health -= damage

#func _on_Hitbox_area_entered(area):
#	var player = area.get_parent()
#	var knockBackDirection = 0
#	if player.global_position.x < self.global_position.x:
#		knockBackDirection = -1
#	else:
#		knockBackDirection = 1
#	player.jump(player.knock_back_force.y)
#	player.knock_back( player.knock_back_force )
