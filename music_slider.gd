extends HSlider


func _ready():
	value = GlobalParameters.sound_level


func _on_value_changed(value):
	GlobalParameters.sound_level = value
