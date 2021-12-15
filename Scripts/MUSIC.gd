extends Node


onready var MusicPlayer = $AudioStreamPlayer

var music_path = "res://Audio/Musica/"
var currentSong = ""
var currentDefaultVolume = 0

var music = {
	"8_bit_adventure": load(music_path + "8_bit_adventure.ogg"),
	"retro_platforming": load(music_path + "retro_platforming.ogg")
}

func Play(songName:String, volume = 1):
	if MusicPlayer.playing:
			if songName == currentSong:
				return
			MusicPlayer.stop()
			MusicPlayer.stream = music[songName]
			MusicPlayer.volume_db = volume
			MusicPlayer.play(0)
			currentSong = songName
			currentDefaultVolume = volume
	else:
			MusicPlayer.stream = music[songName]
			MusicPlayer.volume_db = volume
			MusicPlayer.play(0)
			currentSong = songName
			currentDefaultVolume = volume

func stop():
	if MusicPlayer.playing:
		MusicPlayer.stop()
