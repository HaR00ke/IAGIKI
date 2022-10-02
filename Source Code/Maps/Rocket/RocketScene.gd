extends Node2D

var shake = false

onready var rocket = $Rocket
onready var launch_pos = $LaunchPosition
onready var end_pos = $EndPosition
onready var audio = $AudioStreamPlayer

var mobs = []

func _ready():
	rocket.connect("rocket_returned", self, "change_scene")
	rocket.connect("flew_up", self, "after_flew_up")
	mobs = SavingManager.loadData()["selected_orgs"]
	self.start()

func after_flew_up():
	audio.play()
	rocket.fly_down(launch_pos.global_position, end_pos.global_position)

func start():
	#$Tween/Rocket/Timer.start()
	shake = true
	rocket.fly_up_down(launch_pos.global_position, end_pos.global_position)
	rocket.global_position = launch_pos.global_position
	audio.play()

func _exit_tree():
	audio.stop()

func change_scene():
	var text = calculate()
	if text == "The professor lived 3.5 years of the flight. Congratulations! Professor survived!":
		SceneSwitcher.switch_with_button("res://UI/MainMenu/MainMenu.tscn", text, "Go to main menu")
	else:
		SceneSwitcher.switch_with_button("res://Maps/MainMap/MainMap.tscn", text)


func calculate():
	var dict = SavingManager.loadData()
	var points = dict.get('points', 0)
	if(mobs.find("Fly larvae") == -1):
		#add 10 points
		dict["points"] = (points + 10)
		SavingManager.save(dict)
		return "The professor lived 45 minutes of the flight. You've earned 10 points! The cause of death is high hypergravity during the launching"
	if(mobs.find("Elephant") != -1 or mobs.find("Whales") != -1):
		#add 10 points
		dict["points"] = (points + 10)
		SavingManager.save(dict)
		return "The professor lived 45 minutes of the flight. You've earned 10 points! The cause of death is high hypergravity during the launching as they are too heavy."
	if(mobs.find("Mice") == -1):
		#add 20 points
		dict["points"] = (points + 20)
		SavingManager.save(dict)
		return "The professor lived 2 days of the flight. You've earned 20 points! The cause of death is high microgravity in space."
	if(mobs.find("Lugworms") != -1):
		#add 30 points
		dict["points"] = (points + 30)
		SavingManager.save(dict)
		return 	"The professor lived 7 days of the flight. You've earned 30 points! The cause of death is the lack of nutrients as he couldn’t find food due to microgravity."
	if(mobs.find("Henneguya salminicola (parasite)") == -1):
		#add 30 points
		dict["points"] = (points + 30)
		SavingManager.save(dict)
		return "The professor lived 1 week of the flight. You've earned 30 points! The cause of death is the lack of oxygen."
	if(mobs.find("Deinococcus radiodurans (bacterium)") == -1):
		#add 40 points
		dict["points"] = (points + 40)
		SavingManager.save(dict)
		return "The professor lived 4 weeks after the flight. You've earned 40 points! The cause of death is high radiation."
	if(mobs.find("Turkey") != -1 or mobs.find("Goose") != -1 or mobs.find("Crocodile") != -1):
		#add 40 points
		dict["points"] = (points + 40)
		SavingManager.save(dict)
		return "The professor lived 1 month of the flight. You've earned 40 points! The cause of death is the need for the specific environment."
	if(mobs.find("S. cerevisiae") == -1 and mobs.find("C. albicans") == -1
		and mobs.find("A. fumigatus") == -1 and mobs.find("C. neoformans var. gattii") == -1):
		#add 50 points
		dict["points"] = (points + 50)
		SavingManager.save(dict)
		return "The professor lived 4 months of the flight. You've earned 50 points! The cause of death is oxidative stress."
	if(mobs.find("Tardigrade") == -1 or mobs.find("American pygmy shrew") != -1):
		#add 60 points
		dict["points"] = (points + 60)
		SavingManager.save(dict)
		return "The professor lived 6 months of the flight. You've earned 60 points! The cause of death is lack of meal."
	if(mobs.find("Bullfrog") == -1)	:
		#add 70 points
		dict["points"] = (points + 70)
		SavingManager.save(dict)
		return "The professor lived 9 months of the flight. You've earned 70 points! The cause of death is lack of sleep"
	if(mobs.find("Koala") != -1):
		#add 60 points
		dict["points"] = (points + 60)
		SavingManager.save(dict)
		return "The professor lived 6 months of the flight. You've earned 60 points! The cause of death is lack of sleep."
	if(mobs.find("Methicillin-resistant Staphylococcus aureus") == -1):
		#add 80 points
		dict["points"] = (points + 80)
		SavingManager.save(dict)
		return "The professor lived 3 years of the flight. You've earned 80 points! The cause of death is a disease caused by infections."
	return "The professor lived 3.5 years of the flight. Congratulations! Professor survived!"


