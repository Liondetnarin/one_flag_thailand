extends Node

const HOOKS := {
	"tap_correct": "res://assets/audio/tap_correct.ogg",
	"tap_wrong": "res://assets/audio/tap_wrong.ogg",
	"bomb": "res://assets/audio/bomb.ogg",
	"combo": "res://assets/audio/combo.ogg",
	"countdown": "res://assets/audio/countdown.ogg",
	"game_start": "res://assets/audio/game_start.ogg",
	"game_finish": "res://assets/audio/game_finish.ogg"
}

func play(hook: String) -> void:
	var path: String = HOOKS.get(hook, "")
	if path.is_empty() or not ResourceLoader.exists(path):
		return
	var player := AudioStreamPlayer.new()
	player.stream = load(path)
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()

