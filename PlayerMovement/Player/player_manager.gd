class_name PlayerManager extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_state_machine = $StateMachine

@export_category("Walk settings")
@export var MOVEMENT_SPEED: float = 330

@export_category("Jump Settings")
@export var JUMP_PEAK_TIME: float = 0.35
@export var JUMP_FALL_TIME: float = 0.32
@export var JUMP_HEIGHT: float = 1.5
@export var JUMP_DISTANCE: float = 1.5
@export var GRAVITY_FALL_MODIFIER: float = 3.0

@export_category("Cojote time Settings")
@export var MOVEMENT_SPEED_WHILE_FALLING: float = 300.0
@export var COJOTE_JUMP_TIMER: float = 0.2

@export_category("Attack Settings")
@export var DAMAGE_AMOUNT: int = 20
@export var MOVEMENT_SPEED_WHILE_ATTACKING: int = 300

var can_move: bool = true
var direction: Vector2

var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity

func _init():
	Global.player = self

func _ready():
	gravity = default_gravity

func _process(_delta):
	update_debug_values()

func _input(event):
	#if event.is_action_pressed("testdie"):
	#	player_state_machine.on_child_transition("DeadState")
	pass

func _physics_process(_delta):
	pass

# UTILITY FUNCTIONS

func reset_default_gravity() -> void:
	gravity = default_gravity

func update_gravity(delta) -> void:
	velocity.y += gravity * delta

func update_input(_delta, speed) -> void:
	Global.debug.add_property("Player speed", speed, -1)
	direction.x = Input.get_axis("move_left", "move_right")
	update_sprite_direction()
	
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func update_velocity() -> void:
	if can_move:
		move_and_slide()

func update_sprite_direction() -> void:
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true

func update_debug_values():
	Global.debug.add_property("Player Gravity", str(gravity), -1)
	Global.debug.add_property("Player Direction", str(direction), -1)
	Global.debug.add_property("Cojote timer", 0, -1)
