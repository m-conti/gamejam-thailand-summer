class_name RadioControl extends Control


@export var channels: Array[RadioChannel]

signal sound_changed(current: RadioSound)
signal channel_changed(current: RadioChannel)

var _currentChannelIndex = 0
var currentChannelIndex:
	get: return _currentChannelIndex
	set(value):
		currentSound.currentTime = %Player.get_playback_position()
		_currentChannelIndex = (value + len(channels)) % len(channels)
		if currentSoundIndex == -1:
			currentSoundIndex = randi_range(0, len(currentChannel.sounds) - 1)
		
		var power = currentChannel.power.new()
		%PowerEat.self_modulate = Color(1, 1, 1, 1 if power is CanEat else 0.5)
		%PowerUnbreakable.self_modulate = Color(1, 1, 1, 1 if power is Unbreakable else 0.5)
		%PowerDay.self_modulate = Color(1, 1, 1, 1 if power is Day else 0.5)

		channel_changed.emit(currentChannel)
		sound_changed.emit(currentSound)
var currentChannel: RadioChannel:
	get: return channels[currentChannelIndex]

var currentSoundIndex:
	get: return currentChannel.currentIndex
	set(value):
		currentChannel.currentIndex = (value + len(currentChannel.sounds)) % len(currentChannel.sounds)
		sound_changed.emit(currentSound)

var currentSound: RadioSound:
	get: return currentChannel.sounds[currentSoundIndex]

func _input(event):
	if event.is_action_pressed("radio_next"):
		currentChannelIndex += 1
	if event.is_action_pressed("radio_previous"):
		currentChannelIndex -= 1

func _ready():
	sound_changed.connect(play_sound)
	currentChannelIndex = 0
	%Player.volume_db = GlobalParameters.sound_level

func play_sound(current: RadioSound):
	%Player.stream = current.stream
	%Player.play(current.currentTime)

func _on_player_finished():
	currentSoundIndex += 1


func _on_music_slider_value_changed(value):
	%Player.volume_db = value
