extends CanvasLayer

onready var button = $Button
onready var anim = $Animation


func popup(text: String):
	anim.play("PopUp")
	button.text = text
	yield(get_tree().create_timer(1), "timeout")
	anim.play("PopDown")
