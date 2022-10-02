extends Node2D

onready var player = $MainHero
onready var tablet = $UI/BookTabletUI
onready var computer_screen = $UI/ComputerScreen
onready var pop_up = $UI/PopUp

var current := ""
var player_in := ""
var rocket_scene := "res://Maps/Rocket/RocketScene.tscn"
var main_scene := "res://UI/MainMenu/MainMenu.tscn"
var new_game = true;
var dict = {}

func _ready() -> void:
	tablet.hide()
	computer_screen.hide()
	tablet.connect("close", self, "_on_tablet_close")
	computer_screen.connect("close", self, "_on_tablet_close")
	#if new game
	var dict = SavingManager.loadData()
	new_game = dict.get("new_game", true)
	if(new_game):
		print("ABOBA")
		dict['new_game'] = false
		SavingManager.save(dict)
		SceneSwitcher.connect("end_transition", self, "show_hints")
	

func dict_load():
	dict = SavingManager.loadData()
	new_game = dict.get('new_game', true)	
	
	
func show_hints():
	HintLabel.show_label("Hi! Help me choose organisms that have stress resistance. Some organisms worsen the condition, which leads to death on board.")
	yield(HintLabel, "end_of_hint")
	yield(get_tree().create_timer(0.5), "timeout")
	HintLabel.show_label("To learn the traits of organisms you can do research in the library, which will take a lot of time! And you can also exchange the XP given for the flight for examination in the laboratory. ")
	yield(HintLabel, "end_of_hint")
	yield(get_tree().create_timer(0.5), "timeout")
	HintLabel.show_label("Points is given depending on the percentage of completion of a full flight. Go to the lab to change my DNA!")
	
	
func _on_tablet_close():
	player.set_process(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if current == "library":
			tablet.show()
			player.animation.play("RESET")
			player.set_process(false)
		elif current == "computer":
			computer_screen.show()
			player.animation.play("RESET")
			player.set_process(false)
		elif current == "door":
			SceneSwitcher.switch(rocket_scene, "1.. 2.. 3...")
		elif current == "exit":
			SceneSwitcher.switch(main_scene, "Cleaning...")
		

func show_enter_button(body, text):
	if body.is_in_group("player"):
		body.show_enter_button()
		current = text

func hide_enter_button(body):
	if body.is_in_group("player") and current != "":
		body.hide_enter_button()
		current = ""	

func _on_Library_body_entered(body: Node) -> void:
	show_enter_button(body, "library")
	
func _on_Library_body_exited(body: Node) -> void:
	hide_enter_button(body)
	
func _on_Computer_body_entered(body: Node) -> void:
	show_enter_button(body, "computer")
	
func _on_Computer_body_exited(body: Node) -> void:
	hide_enter_button(body)

func _on_Door_body_entered(body: Node) -> void:
	show_enter_button(body, "door")
	
func _on_Door_body_exited(body: Node) -> void:
	hide_enter_button(body)


func _on_Exit_body_entered(body: Node) -> void:
	show_enter_button(body, "exit")


func _on_Exit_body_exited(body: Node) -> void:
	hide_enter_button(body)


func _on_LabTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player") and player_in != "Research room":
		pop_up.popup(" Research room ")
		player_in = "Research room"

func _on_LibraryTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player") and player_in != "Library":
		pop_up.popup("Library")
		player_in = "Library"


func _on_LaunchTriigger_body_entered(body: Node) -> void:
	if body.is_in_group("player") and player_in != "Launch Zone":
		pop_up.popup("Launch Zone")
		player_in = "Launch Zone"


func _on_ExitTrigger_body_entered(body: Node) -> void:
	if body.is_in_group("player") and player_in != "Exit Zone":
		pop_up.popup("Exit Zone")
		player_in = "Exit Zone"


