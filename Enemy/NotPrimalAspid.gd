extends KinematicBody2D

var positions = [Vector2(-400,200),Vector2(100,200),Vector2(600,200),Vector2(600,400),Vector2(100,400),Vector2(100,600),Vector2(600,600),Vector2(600,200),Vector2(100,200)]

var p = 0
var health = 5
var Effects = null
onready var Bullet = load("res://Enemy/Bullet.tscn")
onready var Explosion = load("res://Effects/Explosion.tscn")

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(50)
		Global.update_time(2)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()

func _ready():
	position = positions[p]
	$Tween.interpolate_property(self, "position", positions[p], positions[p+1], 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	$Tween.start()
	p+= 1 


func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null:
		var bullet = Bullet.instance()
		var d = -PI
		bullet.rotation = d
		bullet.global_position = global_position + Vector2(0,-40).rotated(d)
		Effects.add_child(bullet)
		bullet = Bullet.instance()
		d = -PI-0.2
		bullet.rotation = d
		bullet.global_position = global_position + Vector2(0,-40).rotated(d)
		Effects.add_child(bullet)
		bullet = Bullet.instance()
		d = -PI+0.2
		bullet.rotation = d
		bullet.global_position = global_position + Vector2(0,-40).rotated(d)
		Effects.add_child(bullet)


func _on_Tween_tween_all_completed():
	if p+1 >= positions.size():
		p = 1
		$Tween.interpolate_property(self, "position", positions[p], positions[p+1], 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
		$Tween.start()
		p+=1
	else:
		$Tween.interpolate_property(self, "position", positions[p], positions[p+1], 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
		$Tween.start()
		p+=1
