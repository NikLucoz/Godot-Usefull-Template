class_name CojoteState extends PlayerState

var MOVEMENT_SPEED_WHILE_FALLING: float = 100
var COJOTE_JUMP_TIMER: float = 0.2
var timer: float = COJOTE_JUMP_TIMER

func enter():
	MOVEMENT_SPEED_WHILE_FALLING = Global.player.MOVEMENT_SPEED_WHILE_FALLING
	COJOTE_JUMP_TIMER = Global.player.COJOTE_JUMP_TIMER
	
func exit():
	animated_sprite_2d.stop()
	timer = COJOTE_JUMP_TIMER

func update(delta: float) -> void:
	animated_sprite_2d.play("Fall")
	Global.debug.add_property("Cojote timer", str(timer), -1)
	
	timer -= delta;
	
	if Global.player.is_on_floor():
		transition.emit("IdleState")

func physics_update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_input(delta, MOVEMENT_SPEED_WHILE_FALLING)
	Global.player.update_velocity()

func handle_input(event: InputEvent):
	if timer >= 0:
		if event.is_action_pressed("jump"):
			Global.player.velocity.y = 0 # Ignora per pochissimo la gravità della caduta così da effettuare un salto normale
			transition.emit("JumpState")
