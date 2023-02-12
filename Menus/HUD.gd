extends Control
var lives_pos = Vector2.ZERO
var lives_index = 30
onready var Indicator = load("res://Menus/Lives_Indicator.tscn")



func _ready():
	update_score()
	update_lives()
	update_time()

func update_score():
	$Score.text = "Score: " + str(Global.Score)

func update_time():
	$Time.text = "Time Remaining: " + str(Global.time)

func update_lives():
	lives_pos.x = 20
	lives_pos.y = Global.VP.y - 20
	for child in $Indicator_Container.get_children():
		child.queue_free()
	for i in range(Global.Lives):
		var indicator = Indicator.instance()
		indicator.position = Vector2(lives_pos.x+i*lives_index,lives_pos.y)
		$Indicator_Container.add_child(indicator)


