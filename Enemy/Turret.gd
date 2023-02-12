extends KinematicBody2D

var x_positions = [100,150,200,250,300,350,400,450,500,550]
var initial_position = Vector2.ZERO

var p = 0
var health = 15
var Effects = null
onready var Bullet = load("res://Enemy/Bullet.tscn")
onready var Explosion = load("res://Effects/Explosion.tscn")

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(300)
		Global.update_time(10)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()

func _ready():
	initial_position.y = 0
	initial_position.x = x_positions[randi() % x_positions.size()]
	position = initial_position


func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null:
		var bullet = Bullet.instance()
		var d = global_position.angle_to_point(Player.global_position) - PI/2
		bullet.rotation = d
		bullet.global_position = global_position + Vector2(0,250).rotated(d)
		Effects.add_child(bullet)
