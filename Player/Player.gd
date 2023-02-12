extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 400.0
var health = 2
var sprite = preload("res://Assets/Player.png")
var invulnsprite = preload("res://Assets/Player_Invuln.png")

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Player/Bullet.tscn")
var nose = Vector2(0,-60)



func _ready():
	pass

func _physics_process(_delta):
	print(global_position)
	velocity = get_input()*speed
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = clamp(position.x, 0,Global.VP.x)
	position.y = clamp(position.y, 0,Global.VP.y)

	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	for g in $Primary.get_children():
		if g.has_method("shoot"):
			g.shoot(rotation, global_position)



func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("up"):
		to_return.y -= 1
		$Exhaust.show()
	if Input.is_action_pressed("left"):
		to_return.x -= 1
		$Exhaust.show()
	if Input.is_action_pressed("right"):
		to_return.x += 1
		$Exhaust.show()
	if Input.is_action_pressed("down"):
		to_return.y += 1
		$Exhaust.show()
	if Input.is_action_pressed("focus"):
		speed = 200
	if Input.is_action_just_released("focus"):
		speed = 400
	return to_return


onready var player_sprite = get_node("Sprite")

func switch_texture(s):
	if s == 1:
		player_sprite.set_texture(sprite)
	if s == 2:
		player_sprite.set_texture(invulnsprite)

func damage(d):
	health -= d
	$Area2D.collision_layer = 0
	collision_layer = 0
	$invuln.start()
	switch_texture(2)
	if health <= 0:
		Global.update_lives(-1)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			yield(explosion, "animation_finished")
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name != "Player":
		damage(1)


func _on_invuln_timeout():
	collision_layer = 2
	$Area2D.collision_layer = 1
	switch_texture(1)


func _on_ScoreDrain_timeout():
	Global.update_time(-1)
	$ScoreDrain.start()
