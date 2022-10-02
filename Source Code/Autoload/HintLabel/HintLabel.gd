extends CanvasLayer


onready var player = $AnimationPlayer
onready var label = $ColorRect/Label
onready var color_rect = $ColorRect

signal end_of_hint

func _ready():
	hide()


func show_label(text):
	player.play("show")
	label.text = text
	yield(get_tree().create_timer(len(text.split(' ')) / 3), "timeout")
	hide_label()
	

func hide_label():
	player.play("hide")
	yield($AnimationPlayer, "animation_finished")
	label.text = ""
	emit_signal("end_of_hint")
	
