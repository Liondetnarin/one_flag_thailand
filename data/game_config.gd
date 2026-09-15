class_name GameConfig
extends RefCounted

const GAME_DURATION := 25.0
const START_ALTITUDE := 3000
const BASE_SCORE := 100
const BOMB_PENALTY := 300
const MAX_MULTIPLIER := 5
const MAX_BOMBS := 2
const BONUS_THAI_FLAGS := 8
const FINAL_RUSH_SECONDS := 4.0

# Every gameplay tuning number lives here for quick iteration.
const SPEED_STEPS := [
	{"until": 6.0, "speed": 350.0, "interval": 1.05},
	{"until": 12.0, "speed": 450.0, "interval": 0.88},
	{"until": 18.0, "speed": 550.0, "interval": 0.72},
	{"until": 21.0, "speed": 700.0, "interval": 0.58},
	{"until": 25.0, "speed": 850.0, "interval": 0.46},
]

const EARLY_WEIGHTS := {"thai": 65.0, "usa": 15.0, "uae": 15.0, "bomb": 5.0}
const MID_WEIGHTS := {"thai": 50.0, "usa": 20.0, "uae": 20.0, "bomb": 10.0}
const LATE_WEIGHTS := {"thai": 40.0, "usa": 22.0, "uae": 22.0, "bomb": 16.0}

static func speed_data(elapsed: float) -> Dictionary:
	for step in SPEED_STEPS:
		if elapsed < float(step["until"]):
			return step
	return SPEED_STEPS[-1]

static func weights(elapsed: float) -> Dictionary:
	if elapsed < 8.0:
		return EARLY_WEIGHTS
	if elapsed < 17.0:
		return MID_WEIGHTS
	return LATE_WEIGHTS
