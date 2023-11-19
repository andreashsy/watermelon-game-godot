extends Node

signal merge

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_node = get_node("/root/Main")
	var _unused = self.connect("merge", main_node, "merge_children")

func merge(obj1, obj2):
	emit_signal("merge", obj1, obj2)
