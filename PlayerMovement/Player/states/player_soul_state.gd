class_name SoulState extends PlayerState

var armor_y_offset = 30
var next_armor
func enter():
	next_armor = GameManager.get_next_armor()

func update(_delta):
	if next_armor != null:
		animated_sprite_2d.play("Soul")

func exit():
	Global.GameManager.update_armors_in_scene()

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "Soul":
		if next_armor != null:
			var player_pos = Global.player.position
			
			Global.player.position = Vector2(next_armor.position.x, next_armor.position.y + armor_y_offset)
			next_armor.position = Vector2(player_pos.x + 1.3, player_pos.y - armor_y_offset)
			transition.emit("IdleState")
