extends Node2D

var golf = preload("res://BallScenes/GolfBall.tscn")
var tennis = preload("res://BallScenes/TennisBall.tscn")
var pool = preload("res://BallScenes/PoolBall.tscn")
var base = preload("res://BallScenes/BaseBall.tscn")
var hand = preload("res://BallScenes/HandBall.tscn")
var bowling = preload("res://BallScenes/BowlingBall.tscn")
var foot = preload("res://BallScenes/FootBall.tscn")
var basket = preload("res://BallScenes/BasketBall.tscn")
var beach = preload("res://BallScenes/BeachBall.tscn")

var RANK = 0
var merged_nodes = {}
var score = 0

var ball_map = {
	1: golf,
	2: tennis,
	3: pool,
	4: base,
	5: hand,
	6: bowling,
	7: foot,
	8: basket,
	9: beach,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func merge_children(body1, body2):
	if not merged_nodes.has(body1):
		merged_nodes[body1] = null
		merged_nodes[body2] = null		
		print("Merging " + str(body1) + " and " + str(body2))
		
		var new_rank = body1.RANK + 1
		var new_pos = (body1.get_child(0).global_position + body2.get_child(0).global_position)/2

		score += body1.RANK
		$LabelScore.text = "SCORE: " + str(score)

		body1.queue_free()
		body2.queue_free()
		
		if ball_map.has(new_rank):
			var new_instance = ball_map[new_rank].instance()
			new_instance.position = new_pos
			print(str(new_instance) + " created at " + str(new_pos))
			call_deferred("add_child", new_instance)

func _physics_process(_delta):
	pass
	
func _on_TimerActivateNoTouchZone_timeout():
	print('Reactivating NTZ...')
	$NoTouchZone.monitoring = true
	$Cloud.generate_ball()

func _on_NoTouchZone_body_entered(_body:Node):
	print("Game over")
	if is_instance_valid($Cloud):
		$Cloud.queue_free()
	$TimerActivateNoTouchZone.stop()
