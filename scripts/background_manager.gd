class_name BackgroundManager
extends Control

const VIEW_SIZE := Vector2(1080, 1920)
const BACKGROUND_WIDTH := 1450.0

var game_background: TextureRect
var max_scroll := 0.0

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var fallback := ColorRect.new()
	fallback.position = Vector2.ZERO
	fallback.size = Vector2(1080, 1920)
	fallback.color = Color("42bdec")
	fallback.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fallback)

	game_background = TextureRect.new()
	game_background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	game_background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	game_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var texture_path := "res://assets/backgrounds/bg_game_long.png"
	if not ResourceLoader.exists(texture_path):
		texture_path = "res://assets/backgrounds/bg_sky.png"
	if ResourceLoader.exists(texture_path):
		var texture := load(texture_path) as Texture2D
		game_background.texture = texture
		var display_height := maxf(VIEW_SIZE.y, BACKGROUND_WIDTH * float(texture.get_height()) / float(texture.get_width()))
		game_background.size = Vector2(BACKGROUND_WIDTH, display_height)
		game_background.position.x = (VIEW_SIZE.x - BACKGROUND_WIDTH) * 0.5
		max_scroll = display_height - VIEW_SIZE.y
	else:
		game_background.size = VIEW_SIZE
	add_child(game_background)
	set_altitude(GameConfig.START_ALTITUDE)

func set_altitude(altitude: int) -> void:
	var progress := 1.0 - clampf(float(altitude) / GameConfig.START_ALTITUDE, 0.0, 1.0)
	# One long image scrolls from top to bottom without looping or gaps.
	var scroll := pow(progress, 1.18) * max_scroll
	game_background.position.y = -scroll
