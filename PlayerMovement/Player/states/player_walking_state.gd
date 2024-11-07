class_name WalkState extends PlayerState

var MOVEMENT_SPEED: float

func enter() -> void:
	MOVEMENT_SPEED = Global.player.MOVEMENT_SPEED

func exit() -> void:
	animated_sprite_2d.stop()
	
func update(_delta) -> void:
	if Global.player.direction.x == 0:
		transition.emit("IdleState")
	
	if !Global.player.is_on_floor() and Global.player.velocity.y > 0:
		transition.emit("CojoteState")
	
	animated_sprite_2d.play("Walk")
	
func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_input(delta, MOVEMENT_SPEED)
	Global.player.update_velocity()

func handle_input(event: InputEvent):
	if event.is_action_pressed("jump") and Global.player.is_on_floor():
		transition.emit("JumpState")
	
	#if event.is_action_pressed("attack"):
	#	transition.emit("AttackWhileMovingState")
