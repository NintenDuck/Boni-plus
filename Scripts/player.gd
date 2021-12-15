extends KinematicBody2D

# warning-ignore:unused_signal
signal player_died
# warning-ignore:unused_signal
signal hit_next_level_door(door)

const bone_bullet = preload("res://Scenes/actors/player/bullet_player.tscn")

export var velocity = 2500
export var gravity = 300
export var jumpforce = 110
export var knock_back_force = 700
export var knock_back_force_friction = 0.2
#export var invinsibility_time = 1.0

onready var sprite = $Sprite
onready var animation = $AnimationPlayer
onready var player_stats = $PlayerStats
onready var bullet_init_pos = $Sprite/bulletInitPosition
onready var invinsibilityTimer = $invinsibilityTimer
onready var attackCooldown = $AttackCoolDown
onready var blinkAnimator = $blinkAnimator
onready var shader = sprite.material

var direction = 0
var attack_direction = 0
var last_attack_direction = 1
var can_attack = true
var motion = Vector2.ZERO
var invinsible = false

enum state{
	moving,
	damaged,
	victory,
	attacking,
	changing_level
}
var currentState = state.moving

func _ready():
	if get_parent().name == "World":
		get_parent().plyr = self
	

func _physics_process(delta):
	match currentState:
		state.moving:
			move(delta)
			update_animations()
			check_jump(delta)
			check_attack()
			
		state.damaged:
			move(delta)
			animation.play("damage")
			if is_on_floor():
				change_state_to(state.moving)
				
		state.victory:
			pass
		state.attacking:
			move(delta)
			check_jump(delta)
			animation.play("attack")
		state.changing_level:
			motion = Vector2.ZERO
			animation.play("idle")

func change_state_to(new_state):
	currentState = new_state
#	match currentState:
#		state.moving:
#			print("STATE: MOVING")
#		state.damaged:
#			print("STATE: DAMAGED")
#		state.attacking:
#			print("STATE: ATTACKING")
#		state.victory:
#			print("STATE: VICTORY")
	
func move(delta):
	if is_on_floor():
		direction = get_current_direction()
	attack_direction = get_current_direction()
	
	motion.y += gravity * delta
	motion.x = (velocity * direction) * delta
	motion = move_and_slide( motion, Vector2.UP )
	
func get_current_direction():
	return int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

func check_attack():
	if Input.is_action_just_pressed("attack") and can_attack == true and player_stats.bones_left > 0:
		shoot()
		
		

func shoot():
	change_state_to(state.attacking)
	var bone = Utils.instance_to_main( bone_bullet, bullet_init_pos.global_position )
	bone.direction = last_attack_direction
	player_stats.bones_left -= 1
#	print(player_stats.bones_left)
	can_attack = false
	bone.connect("bone_destroyed", self,"_countup_bone_counter")
	attackCooldown.start()
	Sfx.Play("player_shoot",10,1,true,0.8,1)

func _countup_bone_counter():
	player_stats.bones_left += 1
#	print("Bone signal emitted!!!")
	
# warning-ignore:unused_argument
func check_jump(delta):
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		Sfx.Play("player_jump",1,1,true,0.8,1)
		jump(jumpforce)
		
func jump(force):
	motion.y = 0
	motion.y -= force
	
func knock_back():
#	print("KNOCKBACK!!!")
	jump(jumpforce)
#	motion.x -= knock_back_force
	
func update_animations():
	if attack_direction != 0:
			last_attack_direction = attack_direction
			sprite.scale.x = attack_direction
	if is_on_floor():
		if direction != 0:
			animation.play("walk")
		else:
			animation.play("idle")
	else:
		animation.play("jump")

func _on_Hurtbox_hit(damage):
#	print("Player hit")
	if invinsible == false:
		Sfx.Play("player_damage")
		player_stats.health -= damage
		knock_back()
		invinsibilityTimer.start()
		invinsible = true
		blinkAnimator.play("blink")
#		print("INVINSIBLE")
		change_state_to(state.damaged)

func play_step_sound():
	Sfx.Play("player_step",5)

func restore_health(amount):
	player_stats.health += amount
func _on_invinsibilityTimer_timeout():
	invinsible = false
#	print("NOT INVINSIBLE")

func _on_AttackCoolDown_timeout():
	can_attack = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		change_state_to(state.moving)
