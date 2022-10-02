extends KinematicBody2D

export var speed : int = 500

onready var sprite = $Sprite
onready var enter_button = $EnterButton
onready var animation = $Animation
onready var enter_button_animation = $EnterAnimation

var last_flip_h = false

func _ready() -> void:
	enter_button.modulate.a = 0

func get_movement_input():
	var m_input = Vector2()
	m_input.x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	m_input.y = Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")
	return m_input.normalized()

func _process(delta: float) -> void:
	var m_i = get_movement_input()
	if m_i:
		animation.play("Walk")
		if m_i.x:
			last_flip_h = m_i.x < 0
		sprite.set_flip_h(last_flip_h)
	else:
		animation.play("RESET")
#	if m_i.x < 0: pass #animation.play("left")
#	elif m_i.x > 0: pass #animation.play("right")
#	elif m_i.y < 0: pass #animation.play("up")
#	elif m_i.y > 0: pass #animation.play("down")
#	else: pass #animation.play("idle")
	move_and_slide(get_movement_input() * speed)

func show_enter_button():
	enter_button_animation.play("ShowEnter")

func hide_enter_button():
	enter_button_animation.play("HideEnter")
