extends Control

#onready var btn = $ColorRect/MarginContainer/GridContainer/MusicButton
onready var slider = $ColorRect/HSlider

var dict
# Called when the node enters the scene tree for the first time.
func _ready():
	dict = SavingManager.loadData()
	slider.value = dict.get("music", 80)


func _on_BackButton_pressed():
	SceneSwitcher.switch_directly_scene("res://UI/MainMenu/MainMenu.tscn")


func _on_HSlider_value_changed(value):
	dict["music"] = value
	BackgroundMusic.set_volume(value)
	SavingManager.save(dict)


func _on_HSlider_mouse_exited():
	self.release_focus()
