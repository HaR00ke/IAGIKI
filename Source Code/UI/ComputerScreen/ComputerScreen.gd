extends CanvasLayer

signal close

onready var animation = $AnimationPlayer
onready var org_name = $ColorRect3/OrganismName
onready var org_description = $ColorRect3/OrganismDescription
onready var org_price = $ColorRect3/OrganismPrice
onready var org_texture = $ColorRect3/TextureRect2
onready var get_traits_button = $ColorRect3/HBoxContainer/GetTraitsButton
onready var explore_button = $ColorRect3/HBoxContainer/ExploreButton
onready var points_button = $Points

var organisms : Array
var curr_org = ""

func _ready() -> void:
	organisms = loadData()
	curr_org = organisms[0]
	show_curr_organism()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self._on_GoBack_pressed()

func show_curr_organism():
	var a = SavingManager.loadData()
	
	
	animation.play("Hide")
	yield(animation, "animation_finished")
	
	org_name.text = curr_org["name"]
	org_description.text = "To get information about this organism, you have to explore it!"
	org_texture.texture = load("UI/ComputerScreen/Organisms/" + curr_org["img"])
	points_button.text = str(a["points"])
	get_traits_button.text = "Get traits" if a["selected_orgs"].find(curr_org["name"]) == -1 else "Remove traits" 
	
	if a["explored_orgs"].find(curr_org["name"]) != -1:
		explore_button.disabled = true
		org_description.text = curr_org["desc"]
		org_price.text = "Explored"
	else:
		org_price.text = "Organism price: " + curr_org["price"] + " points"
		explore_button.disabled = a["points"] < int(curr_org["price"])
	animation.play("Show")
	yield(animation, "animation_finished")


func _on_GoBack_pressed() -> void:
	hide()
	emit_signal("close")


func _on_PreviousButton_pressed() -> void:
	var index = organisms.find(curr_org) - 1
	curr_org = organisms[index]
	show_curr_organism()

func _on_NextButton_pressed() -> void:
	var index = organisms.find(curr_org) + 1
	if (index >= len(organisms)):
		index -= len(organisms)
	curr_org = organisms[index]
	show_curr_organism()

func _on_GetTraitsButton_pressed() -> void:
	var a = SavingManager.loadData()
	if get_traits_button.text == "Get traits":
		a["selected_orgs"].append(curr_org["name"])
		get_traits_button.text = "Remove traits"
	else:
		a["selected_orgs"].erase(curr_org["name"])
		get_traits_button.text = "Get traits" 
	SavingManager.save(a)


func _on_ExploreButton_pressed() -> void:
	var a = SavingManager.loadData()
	
	if a["points"] >= int(curr_org["price"]):
		a["explored_orgs"].append(curr_org["name"])
		a["points"] -= int(curr_org["price"])
		SavingManager.save(a)
		show_curr_organism()

func loadData () -> Array:
	var file = File.new()
	file.open("res://UI/ComputerScreen/organisms.json", File.READ)
	var text = file.get_as_text()
	var dict = {}
	dict = parse_json(text)
	file.close()
	return [
  {
	"name": "Methicillin-resistant Staphylococcus aureus",
	"desc": "Resistant to foreign organisms",
	"img": "MRSA.PNG",
	"price": "15"
  },
  {
	"name": "Koala",
	"desc": "Sleep up to 20 hours per day",
	"img": "coala.PNG",
	"price": "15"
  },
  {
	"name": "Bullfrog",
	"desc": "Can live without sleep for a long time",
	"img": "frog.PNG",
	"price": "25"
  },
  {
	"name": "Mice",
	"desc": "Resistance to microgravity in space. Hyperactivity leads to high blood pressure. It may cause stroke and heart attack.",
	"img": "mice.png",
	"price": "20"
  },
  {
	"name": "Lugworms",
	"desc": "Less need for oxygen. Due to microgravity can’t eat",
	"img": "worm.PNG",
	"price": "20"
  },
  {
	"name": "C. neoformans var. gattii",
	"desc": "Resistance to oxidative stress as it has SOD genes",
	"img": "gattii.png",
	"price": "35"
  },
  {
	"name": "American pygmy shrew",
	"desc": "High need for food",
	"img": "shrew.PNG",
	"price": "15"
  },
  {
	"name": "Turkey",
	"desc": "Need for the specific environment",
	"img": "turkey.PNG",
	"price": "30"
  },
  {
	"name": "Goose",
	"desc": "Need for the specific environment",
	"img": "Goose.PNG",
	"price": "15"
  },
  {
	"name": "Whales",
	"desc": "Too heavy",
	"img": "whale.PNG",
	"price": "50"
  },
  {
	"name": "S. cerevisiae",
	"desc": "Resistance to oxidative stress as it has 2 SOD genes",
	"img": "cerevisiae.PNG",
	"price": "15"
  },
  {
	"name": "C. albicans",
	"desc": "Resistance to oxidative stress as it has 6 SOD genes",
	"img": "albicans.PNG",
	"price": "15"
  },
  {
	"name": "Henneguya salminicola (parasite)",
	"desc": "No need for oxygen",
	"img": "Henneguya salminicola.PNG",
	"price": "20"
  },
  {
	"name": "Fly larvae",
	"desc": "Resistance to hypergravity during the launching and landing of the spacecraft",
	"img": "larvae.png",
	"price": "15"
  },
  {
	"name": "Rabbit",
	"desc": "It has no special features",
	"img": "rabbit.PNG",
	"price": "50"
  },
  {
	"name": "Crocodile",
	"desc": "Need for the specific environment",
	"img": "crocodile.PNG",
	"price": "20"
  },
  {
	"name": "Deinococcus radiodurans (bacterium)",
	"desc": "Resistance to radiation",
	"img": "Deinococcus radiodurans.PNG",
	"price": "15"
  },
  {
	"name": "Tardigrade",
	"desc": "Can live without food for a long time during cryptobiosis.",
	"img": "tardigrade.PNG",
	"price": "20"
  },
  {
	"name": "A. fumigatus",
	"desc": "Resistance to oxidative stress as it has 2 SOD genes",
	"img": "fumigatus.PNG",
	"price": "15"
  },
  {
	"name": "Elephant",
	"desc": "Sleep 2 hours per day. Too heavy",
	"img": "elephant.PNG",
	"price": "40"
  }
]
