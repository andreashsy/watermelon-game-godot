extends Node2D

var yellow_smiley = preload("res://SceneFaces/YellowSmileyFace.tscn")
var purple_smiley = preload("res://SceneFaces/PurpleSmileyFace.tscn")
var blue_smiley = preload("res://SceneFaces/BlueSmileyFace.tscn")
var green_smiley = preload("res://SceneFaces/GreenSmileyFace.tscn")
var red_smiley = preload("res://SceneFaces/RedSmileyFace.tscn")
var RANK = 0
var merged_nodes = {}

var smiley_map = {
	8: yellow_smiley,
	9: purple_smiley,
	10: green_smiley,
	11: blue_smiley,
	12: red_smiley
}

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

func merge_children(body1, body2):
	if not merged_nodes.has(body1):
		merged_nodes[body1] = null
		merged_nodes[body2] = null		
		print("Merging " + str(body1) + " and " + str(body2))
		
		var new_rank = body1.RANK + 1
		var new_pos = (body1.get_child(0).global_position + body2.get_child(0).global_position)/2

		body1.queue_free()
		body2.queue_free()
		
		if smiley_map.has(new_rank):
			var new_instance = smiley_map[new_rank].instance()
			new_instance.position = new_pos
			print(str(new_instance) + " created at " + str(new_pos))
			call_deferred("add_child", new_instance)

func _physics_process(_delta):
	pass
	
func _on_TimerActivateNoTouchZone_timeout():
	print('Reactivating NTZ...')
	$NoTouchZone.monitoring = true
	$Cloud.generate_circle()

func _on_NoTouchZone_body_entered(_body:Node):
	print("Game over")
	$Cloud.queue_free()
	$TimerActivateNoTouchZone.stop()
