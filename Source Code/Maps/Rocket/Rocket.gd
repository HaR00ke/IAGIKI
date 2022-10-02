extends Sprite

onready var camera = $Camera2D
var shake_amount = 0

signal rocket_returned
signal flew_up

func fly_up_down(start_pos, end_pos):	
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "global_position", end_pos, 15)
	shake_amount = 5
	tween.parallel().tween_property(self, "shake_amount", 0, 10)
	
	yield(get_tree().create_timer(14.6), "timeout")
	SceneSwitcher.fade_in_out("After 3.5 years", 1)
	yield(get_tree().create_timer(1.6), "timeout")
	
	emit_signal("flew_up")

func fly_down(start_pos, end_pos):
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", start_pos, 15)
	shake_amount = 0
	tween.parallel().tween_property(self, "shake_amount", 5, 12)
	
	yield(get_tree().create_timer(12), "timeout")
	var tween2 = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween2.tween_property(self, "shake_amount", 0, 1.5)
	tween2.connect("finished", self, "end_of_scene")
	
func _process(delta: float) -> void:
	if shake_amount:
		camera.set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
		))

func end_of_scene():
	$FireParticles.emitting = false
	$Light2D.hide()
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("rocket_returned")
