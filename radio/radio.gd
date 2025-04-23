class_name RadioControl extends Control


@export var channels: Array[RadioChannel]

signal sound_changed(current: RadioSound)
signal channel_changed(current: RadioChannel)

var _currentChannelIndex = 0
var currentChannelIndex:
	get: return _currentChannelIndex
	set(value):
		_currentChannelIndex = (value + len(channels)) % len(channels)
		currentSoundIndex = 0
		channel_changed.emit(currentChannel)
var currentChannel: RadioChannel:
	get: return channels[currentChannelIndex]

var _currentSoundIndex = 0
var currentSoundIndex:
	get: return _currentSoundIndex
	set(value):
		_currentSoundIndex = (value + len(currentChannel.sounds)) % len(currentChannel.sounds)
		sound_changed.emit(currentSound)

var currentSound: RadioSound:
	get: return currentChannel.sounds[currentSoundIndex]

func _ready():
	sound_changed.connect(play_sound)
	currentChannelIndex = randi_range(0, len(channels) - 1)
	currentSoundIndex = randi_range(0, len(currentChannel.sounds) - 1)

func play_sound(current: RadioSound):
	%Player.stream = current.stream
	%Player.play()

func _on_player_finished():
	currentSoundIndex += 1
