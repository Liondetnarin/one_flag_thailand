extends Node

const MOCK_PATH := "res://data/mock_leaderboard.json"

func get_entries(current_score: int = 0) -> Array:
	var entries: Array = []
	if FileAccess.file_exists(MOCK_PATH):
		var parsed = JSON.parse_string(FileAccess.get_file_as_string(MOCK_PATH))
		if parsed is Array:
			entries = parsed.duplicate(true)
	for entry in entries:
		if str(entry.get("name", "")) == "You":
			entry["score"] = current_score
	entries.sort_custom(func(a, b): return int(a.get("score", 0)) > int(b.get("score", 0)))
	return entries

func estimate_rank(score: int) -> int:
	# Replace this method with a REST request when Supabase is connected.
	var better := 0
	for entry in get_entries(score):
		if str(entry.get("name", "")) != "You" and int(entry.get("score", 0)) > score:
			better += 1
	return better + 1

