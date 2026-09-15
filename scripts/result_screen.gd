extends Control

func _ready() -> void:
	var bg := TextureRect.new()
	UIFactory.fill_parent(bg)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	if ResourceLoader.exists("res://assets/backgrounds/bg_finish.png"):
		bg.texture = load("res://assets/backgrounds/bg_finish.png")
	add_child(bg)
	var shade := ColorRect.new()
	UIFactory.fill_parent(shade)
	shade.color = Color(0.01, 0.08, 0.25, 0.35)
	shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(shade)

	var title := UIFactory.make_label("MISSION\nCOMPLETE!", 96, Color("ffe03e"))
	title.position = Vector2(90, 170)
	title.size = Vector2(900, 300)
	add_child(title)
	var card := Panel.new()
	card.position = Vector2(115, 500)
	card.size = Vector2(850, 800)
	card.add_theme_stylebox_override("panel", UIFactory.panel_style(Color(0.02, 0.16, 0.43, 0.94), 52, Color("68ddff"), 6))
	add_child(card)
	var stack := VBoxContainer.new()
	stack.position = Vector2(70, 55)
	stack.size = Vector2(710, 680)
	stack.add_theme_constant_override("separation", 10)
	card.add_child(stack)
	var result: Dictionary = GameManager.last_result
	add_stat(stack, "THAI FLAGS COLLECTED", str(result.get("flags", 0)), Color("ffe04b"))
	add_stat(stack, "TOTAL SCORE", str(result.get("score", 0)), Color.WHITE)
	add_stat(stack, "BEST COMBO", "x%d" % result.get("best_combo", 0), Color("65ddff"))
	add_stat(stack, "RANK", "#%d" % result.get("rank", 128), Color("ff6872"))

	var buttons := VBoxContainer.new()
	buttons.position = Vector2(190, 1370)
	buttons.size = Vector2(700, 470)
	buttons.alignment = BoxContainer.ALIGNMENT_CENTER
	buttons.add_theme_constant_override("separation", 20)
	add_child(buttons)
	var again := UIFactory.make_button("↻  PLAY AGAIN", Color("ef3340"), Vector2(700, 130))
	again.pressed.connect(func(): GameManager.request_screen("game"))
	buttons.add_child(again)
	var row := HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_theme_constant_override("separation", 22)
	buttons.add_child(row)
	var home := UIFactory.make_button("HOME", Color("1769d2"), Vector2(300, 110))
	home.pressed.connect(func(): GameManager.request_screen("start"))
	row.add_child(home)
	var share := UIFactory.make_button("SHARE", Color("1769d2"), Vector2(300, 110))
	share.pressed.connect(_share_result)
	row.add_child(share)
	var ranks := UIFactory.make_button("VIEW RANKING", Color("0a9169"), Vector2(540, 100))
	ranks.pressed.connect(func(): GameManager.request_screen("leaderboard"))
	buttons.add_child(ranks)
	card.scale = Vector2(0.84, 0.84)
	card.pivot_offset = card.size * 0.5
	create_tween().tween_property(card, "scale", Vector2.ONE, 0.45).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func add_stat(parent: VBoxContainer, title_text: String, value_text: String, value_color: Color) -> void:
	var title := UIFactory.make_label(title_text, 30, Color("8ce7ff"))
	title.custom_minimum_size = Vector2(710, 48)
	parent.add_child(title)
	var value := UIFactory.make_label(value_text, 66, value_color)
	value.custom_minimum_size = Vector2(710, 100)
	parent.add_child(value)

func _share_result() -> void:
	var result: Dictionary = GameManager.last_result
	var message := "ONE FLAG THAILAND — I scored %d and found %d Thai flags!" % [result.get("score", 0), result.get("flags", 0)]
	DisplayServer.clipboard_set(message)
	var toast := UIFactory.make_label("RESULT COPIED!", 36, Color("ffe04b"))
	toast.position = Vector2(290, 1260)
	toast.size = Vector2(500, 80)
	add_child(toast)
	create_tween().tween_property(toast, "modulate:a", 0.0, 1.1).set_delay(0.7).finished.connect(toast.queue_free)

