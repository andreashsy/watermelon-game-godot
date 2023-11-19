extends Node2D

var circle = preload("res://YellowSmileyFace.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#generate_random(400, 800, circle, 20, 0.5)
	pass

func generate_random(x_min: int, x_max: int, obj, num_times: int, delay: float):
	randomize()
	for n in num_times:
		print("Loop " + str(n) + " of " + str(num_times))
		yield(wait(delay), "completed")
		
		var obj_instance = obj.instance()
		obj_instance.position = Vector2(rand_range(x_min, x_max), 300)
		
		add_child(obj_instance)

func wait(seconds: float):
	yield(get_tree().create_timer(seconds), "timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
