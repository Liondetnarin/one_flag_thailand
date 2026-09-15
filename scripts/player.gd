extends Node2D

func _ready() -> void:
	var sprite := $Sprite2D as Sprite2D
	if ResourceLoader.exists("res://assets/characters/character_fall.png"):
		sprite.texture = load("res://assets/characters/character_fall.png")
	elif ResourceLoader.exists("res://assets/characters/character_sheet.png"):
		var atlas := AtlasTexture.new()
		atlas.atlas = load("res://assets/characters/character_sheet.png")
		# Tight crop around the top-right falling pose; excludes the next sprite row.
		atlas.region = Rect2(520, 0, 602, 500)
		sprite.texture = atlas
	else:
		queue_redraw()

func _draw() -> void:
	if $Sprite2D.texture == null:
		draw_circle(Vector2.ZERO, 130, Color("ff8c24"))
		draw_circle(Vector2(0, 55), 115, Color("171c28"))
		draw_circle(Vector2.ZERO, 130, Color.WHITE, false, 8)
