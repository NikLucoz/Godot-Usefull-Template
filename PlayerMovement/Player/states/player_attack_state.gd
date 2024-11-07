class_name PlayerAttackState extends PlayerState

var DAMAGE_AMOUNT: int
var secondAttack: bool = false

func enter():
	DAMAGE_AMOUNT = Global.player.DAMAGE_AMOUNT
	
	animated_sprite_2d.stop()
	right_weapon_range.monitoring = false
	left_weapon_range.monitoring = false
	
func exit():
	right_weapon_range.monitoring = false
	left_weapon_range.monitoring = false

func update(_delta):
	Global.debug.add_property("Attack1", str(secondAttack), -1)
	animated_sprite_2d.play("Attack1")
	
	enable_correct_attack_area()

func _on_animated_sprite_2d_animation_finished():
	transition.emit("IdleState")

func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_velocity()

func _on_right_weapon_range_body_entered(body):
	check_if_has_health_controller(body)

func _on_left_weapon_range_body_entered(body):
	check_if_has_health_controller(body)

func check_if_has_health_controller(body):
	if body.has_node("HealthController"):
		print(body)
		var HC: HealthController = body.get_node("HealthController")
		HC.deal_damage(DAMAGE_AMOUNT)

func enable_correct_attack_area():
	if animated_sprite_2d.flip_h == true: # Guarda a sinistra
		right_weapon_range.monitoring = false
		left_weapon_range.monitoring = true
	else:
		right_weapon_range.monitoring = true
		left_weapon_range.monitoring = false
