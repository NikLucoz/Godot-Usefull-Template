class_name DeadState extends PlayerState

@onready var timer = $Timer

func enter():
	animated_sprite_2d.play("Dead")
	timer.start()

func update(delta):
	Global.player.update_gravity(delta)
	Global.player.update_velocity()

func _on_timer_timeout():
	print("Respawn") # Respawn player
	timer.stop()
