extends Node2D

onready var TurretEnemy = load("res://Enemy/Turret.tscn")
onready var NPA = load("res://Enemy/NotPrimalAspid.tscn")

var enemy_list = []

func _ready():
	enemy_list = [TurretEnemy, NPA, NPA, NPA]


var e = 0

func _physics_process(_delta):
	if get_child_count() == 1:
		e = 0

func _on_Timer_timeout():
	if e < enemy_list.size():
		if enemy_list[e] != null:
			var enemy = enemy_list[e].instance()
			add_child(enemy)
		e += 1

