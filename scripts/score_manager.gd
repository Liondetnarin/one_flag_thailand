extends Node

signal score_changed(score: int)
signal combo_changed(multiplier: int, consecutive: int)

var score := 0
var consecutive := 0
var best_combo := 0
var thai_flags := 0

func reset() -> void:
	score = 0
	consecutive = 0
	best_combo = 0
	thai_flags = 0
	score_changed.emit(score)
	combo_changed.emit(1, consecutive)

func collect_thai() -> int:
	var multiplier: int = mini(consecutive + 1, GameConfig.MAX_MULTIPLIER)
	var gained: int = GameConfig.BASE_SCORE * multiplier
	score += gained
	consecutive += 1
	best_combo = maxi(best_combo, consecutive)
	thai_flags += 1
	score_changed.emit(score)
	combo_changed.emit(mini(consecutive + 1, GameConfig.MAX_MULTIPLIER), consecutive)
	return gained

func reset_combo() -> void:
	consecutive = 0
	combo_changed.emit(1, consecutive)

func hit_bomb() -> int:
	score = maxi(0, score - GameConfig.BOMB_PENALTY)
	reset_combo()
	score_changed.emit(score)
	return GameConfig.BOMB_PENALTY

