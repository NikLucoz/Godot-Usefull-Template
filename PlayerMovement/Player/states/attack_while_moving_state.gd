class_name PlayerAttackWhileMovingState extends PlayerAttackState

var MOVEMENT_SPEED_WHILE_ATTACKING: int

func enter():
	MOVEMENT_SPEED_WHILE_ATTACKING = Global.player.MOVEMENT_SPEED_WHILE_ATTACKING
	animated_sprite_2d.stop()

func update(_delta):
	Global.debug.add_property("Attack1", str(secondAttack), -1)
	animated_sprite_2d.play("Attack1")
	enable_correct_attack_area()

func _on_animated_sprite_2d_animation_finished():
	transition.emit("WalkState")

func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_velocity()
	Global.player.update_input(delta, MOVEMENT_SPEED_WHILE_ATTACKING)
