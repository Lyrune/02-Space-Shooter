extends Node2D

onready var Player = load("res://Player/Player.tscn")
var invuln = null

func _physics_process(_delta):
	if get_child_count() == 0:
		var player = Player.instance()
		player.position = Vector2(Global.VP.x/2,Global.VP.y - 100)
		add_child(player)
