extends Node

onready var SoundPlayers = get_children()

var sfx_path = "res://Audio/Sfx/"

var sounds = {
	"player_damage": load(sfx_path + "player_damage_sfx.wav"),
	"player_jump": load(sfx_path + "player_jump_sfx.wav"),
	"player_shoot": load(sfx_path + "player_shoot_sfx.wav"),
	"player_bread": load(sfx_path + "player_bread_sfx.wav"),
	"player_step": load(sfx_path + "player_step_sfx.wav"),
	"enemy_damage": load(sfx_path + "enemy_damage_sfx.wav"),
	"enemy_throw": load(sfx_path + "enemy_throw_sfx.wav"),
	"enemy_bullet": load(sfx_path + "enemy_bullet_sfx.wav"),
	"flag_sfx": load(sfx_path + "flag_sfx.wav")
}

func Play(sound_string:String, volume_db = 1, pitch_scale = 1, random_pitch=false, pitch_range_min=0, pitch_range_max=0):
	for soundPlayer in SoundPlayers:
		if not soundPlayer.playing:
			if random_pitch:
				soundPlayer.pitch_scale = rand_range(pitch_range_min,pitch_range_max)
			else:
				soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
