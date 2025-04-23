class_name RadioControl extends Control


@export var channels: Array[RadioChannel]

var _currentChannelIndex = 0
var currentChannelIndex:
	get: return _currentChannelIndex
	set(value): _currentChannelIndex = (value + len(channels)) % len(channels)
var currentChannel: RadioChannel:
	get: return channels[currentChannelIndex]

var _currentSoundIndex = 0
var currentSoundIndex:
	get: return _currentSoundIndex
	set(value): _currentSoundIndex = (value + len(currentChannel.sounds)) % len(currentChannel.sounds)

var currentSound:
	get: return currentChannel.sounds[currentSoundIndex]

func _ready():
	currentChannelIndex = randi_range(0, len(channels))
	currentSoundIndex = randi_range(0, len(currentChannel.sounds))
	print_debug(len(currentChannel.sounds))
	%Player.stream = currentSound
	%Player.play()


func _on_player_finished():
	currentSoundIndex += 1
	%Player.stream = currentSound
	%Player.play()
