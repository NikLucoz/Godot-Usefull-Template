class_name JumpState extends PlayerState

var JUMP_PEAK_TIME: float
var JUMP_FALL_TIME: float
var JUMP_HEIGHT: float
var JUMP_DISTANCE: float
var GRAVITY_FALL_MODIFIER: float

var jump_velocity
var jump_gravity
var fall_gravity
var movement_speed_while_jumping

func enter():
	JUMP_PEAK_TIME = Global.player.JUMP_PEAK_TIME
	JUMP_FALL_TIME = Global.player.JUMP_FALL_TIME
	JUMP_HEIGHT = Global.player.JUMP_HEIGHT * Global.tileSize
	JUMP_DISTANCE = Global.player.JUMP_DISTANCE * Global.tileSize
	GRAVITY_FALL_MODIFIER = Global.player.GRAVITY_FALL_MODIFIER
	calculate_jump()
	Global.player.velocity.y = jump_velocity
	Global.player.gravity = jump_gravity
	
func exit():
	Global.player.reset_default_gravity()

func update(_delta: float) -> void:
	animated_sprite_2d.play("Jump")
	if Global.player.is_on_floor() and Global.player.velocity.y == 0:
		transition.emit("IdleState")

func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_input(delta, movement_speed_while_jumping)
	Global.player.update_velocity()

func handle_input(event: InputEvent):
	#if event.is_action_pressed("attack"):
	#	transition.emit("AttackState")
	
	if event.is_action_released("jump"):
		Global.player.gravity *= GRAVITY_FALL_MODIFIER

func calculate_jump():
	jump_gravity = (2 * JUMP_HEIGHT) / pow(JUMP_PEAK_TIME, 2)
	jump_velocity = -(jump_gravity * JUMP_PEAK_TIME)
	movement_speed_while_jumping = JUMP_DISTANCE / (JUMP_PEAK_TIME + JUMP_FALL_TIME)
