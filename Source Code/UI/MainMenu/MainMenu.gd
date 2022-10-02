extends Control

var new_game = true
onready var continueBtn = $VBoxContainer/ContinueButton
onready var dialog = $ConfirmationDialog

func _ready():
	var dict = SavingManager.loadData()
	BackgroundMusic.set_volume(dict["music"])
	new_game = dict.get('new_game', true)
	dialog.get_cancel().text = "No"
	#dialog.get_cancel().connect("pressed", self, "cancelDialog")
	dialog.get_ok().text = 'Yes'
	dialog.get_ok().connect("pressed", self, "okDialog")
	if(!new_game):
		continueBtn.visible = true
		continueBtn.disabled = false


func _on_playGameButton_pressed():
	if(new_game):
		SceneSwitcher.switch_start_dialog("res://Maps/MainMap/MainMap.tscn", "Skip")
	else:
		#show popup
		dialog.show()
		#SceneSwitcher.switch("res://Maps/MainMap/MainMap.tscn", "Welcome to Laboratory")


func _on_ContinueButton_pressed():
	SceneSwitcher.switch("res://Maps/MainMap/MainMap.tscn", "Welcome to Laboratory")


func _on_settingsButton_pressed():
	SceneSwitcher.switch_directly_scene("res://UI/Settings/Settings.tscn")


func _on_quiButton_pressed():
	get_tree().quit()	


func okDialog():
	SavingManager.save({"new_game": true, "points": 0, "music": SavingManager.loadData()["music"], "selected_orgs": [], "explored_orgs": []})
	SceneSwitcher.switch_start_dialog("res://Maps/MainMap/MainMap.tscn", "Skip")
	
