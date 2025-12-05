extends Control

var value = 0
var label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $Label
	pass # Replace with function body.

func init(v: int):
	value = v
	label.text = str(value)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
