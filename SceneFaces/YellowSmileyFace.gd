extends Node2D

var RANK = 8
signal merge(obj1, obj2)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("RigidBody2DYellowSmileyFace").contact_monitor = true
	get_node("RigidBody2DYellowSmileyFace").contacts_reported = 20
	self.connect("merge", self.get_parent().get_parent(), "merge_children")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RigidBody2DYellowSmileyFace_body_entered(body):
	var other_rank = body.get_parent().RANK
	#print(str(self.name) + " collided with " + str(body.name) + " of rank " + str(other_rank))
	if self.RANK == other_rank:
		emit_signal("merge", self, body.get_parent())
