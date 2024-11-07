class_name IdleState extends PlayerState

func enter() -> void:
	Global.player.velocity.x = 0
	
func exit() -> void:
	animated_sprite_2d.stop()
	
func update(_delta) -> void:
	if Global.player.direction.x != 0 and Global.player.is_on_floor():
		transition.emit("WalkState")
	
	if !Global.player.is_on_floor() and Global.player.velocity.y > 0:
		transition.emit("CojoteState")
	
	animated_sprite_2d.play("Idle")

func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_input(delta, 0)
	Global.player.update_velocity()

func handle_input(event: InputEvent):
	#if event.is_action_pressed("attack"):
	#	transition.emit("AttackState")
	
	if event.is_action_pressed("jump") and Global.player.is_on_floor():
		transition.emit("JumpState")
	
	#if event.is_action_pressed("soul"):
	#	transition.emit("SoulState")
