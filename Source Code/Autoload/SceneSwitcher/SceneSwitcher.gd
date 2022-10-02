extends Node

onready var anim = $AnimationPlayer
onready var rect = $OverlayLayer/ColorRect
onready var text = $OverlayLayer/TitleOfScene
onready var button = $OverlayLayer/Button

signal end_transition

func _ready():
	rect.hide()
	text.hide()
	button.hide()


func switch(scene: String, title: String="", duration=2):
	text.text = title
	anim.play("fade_in")
	yield(anim, "animation_finished")
	
	get_tree().change_scene(scene)
	
	yield(get_tree().create_timer(max(duration, len(title.split(' ')) / 3)), "timeout")
	
	anim.play("fade_out")
	yield(anim, "animation_finished")
	
	
func fade_in_out(title: String = "", duration: float = 1.5):
	text.text = title
	anim.play("fade_in")
	yield(anim, "animation_finished")
	
	yield(get_tree().create_timer(max(duration, len(title.split(' ')) / 3)), "timeout")
	
	anim.play("fade_out")
	yield(anim, "animation_finished")
	
func switch_with_button(scene:String, title: String, button_text:String = "Ok"):
	button.show()
	button.text = button_text
	anim.play("fade_in")
	text.text = title
	yield(anim, "animation_finished")
	
	get_tree().change_scene(scene)
	yield(button, "pressed")
	
	anim.play("fade_out")
	yield(anim, "animation_finished")
	button.hide()
	
func switch_start_dialog(scene:String, button_text:String = "Ok"):
	button.show()
	button.text = button_text
	
	anim.play("fade_in")
	text.text = TextPhrases.text_after_starting_game1
	yield(anim, "animation_finished")
	yield(button, "pressed")
	text.text = TextPhrases.text_after_starting_game2
	get_tree().change_scene(scene)
	yield(button, "pressed")
	anim.play("fade_out")
	yield(anim, "animation_finished")
	button.hide()
	emit_signal("end_transition")
	
func switch_directly_scene(scene: String):
	get_tree().change_scene(scene)
