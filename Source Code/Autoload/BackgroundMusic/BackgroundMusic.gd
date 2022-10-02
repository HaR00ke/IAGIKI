extends Node2D

onready var audio = $AudioStreamPlayer

var volume_offset = -80

func set_volume(val):
	audio.volume_db = val + volume_offset

func pause_music():
	audio.stream_paused = true

func resume_music():
	audio.stream_paused = false
