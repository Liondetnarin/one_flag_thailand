# ONE FLAG THAILAND — Falling Tap Game

A mobile-first Godot 4 prototype using the supplied artwork. The playable loop is start, countdown, 25-second fall, landing, results, replay, and local leaderboard.

## Run

Open `project.godot` in Godot 4.x and press **F6/F5**. The entry point is `res://scenes/Main.tscn`. Mouse clicks work on desktop; `Area2D.input_event` also handles `InputEventScreenTouch` on phones.

## Tuning

All first-pass balance values are in `res://data/game_config.gd`:

- `SPEED_STEPS`: movement speed and spawn interval for each time band.
- `EARLY_WEIGHTS`, `MID_WEIGHTS`, `LATE_WEIGHTS`: editable Thai/USA/UAE/bomb percentages.
- `BASE_SCORE`, `BOMB_PENALTY`, and `MAX_MULTIPLIER`: scoring.
- `GAME_DURATION` and `START_ALTITUDE`: run length/progress.

## Art replacement

The included source sheets are already wired through atlas regions. Optional standalone PNGs take priority automatically:

- `assets/characters/character_fall.png`
- `assets/flags/thai_flag.png`, `usa_flag.png`, `uae_flag.png`
- `assets/obstacles/bomb.png`
- `assets/backgrounds/bg_game_long.png` is the active non-looping gameplay background. Other background names remain available for future phases.
- `assets/ui/logo_one_flag_thailand.png`

If an optional gameplay image is missing, the code uses the supplied sheet and finally a drawn fallback. Backgrounds and logo also check before loading.

Drop optional OGG audio into `assets/audio/` using: `tap_correct.ogg`, `tap_wrong.ogg`, `bomb.ogg`, `combo.ogg`, `countdown.ogg`, `game_start.ogg`, and `game_finish.ogg`. Missing audio is silently skipped.

## Structure

- `scenes/`: screen scenes and entry point.
- `objects/`: reusable Thai, USA, UAE, bomb, and player scenes.
- `scripts/`: routing, gameplay, spawner, score, backgrounds, leaderboard, audio, and UI helpers.
- `data/`: balance config and mock leaderboard JSON.
- `ui/`: reusable HUD/pause scene stubs for editor expansion.
- `tests/`: headless end-to-end smoke test.

`LeaderboardManager.get_entries()` is isolated from gameplay. Replace that service with a Supabase/REST request later without changing the game screen.

## Web export

Install the Godot 4.7 export templates from **Editor → Manage Export Templates**. Then choose **Project → Export → Web** and export to `build/web/index.html`. The included preset uses the compatibility renderer, no threads, portrait canvas scaling, and mobile-friendly input. Upload every generated file in `build/web/` to an HTTPS static host.

CLI equivalent after templates are installed:

```powershell
Godot_v4.7-stable_win64.exe --headless --path C:\Users\User\one_flag_thailand --export-release Web build\web\index.html
```

Run the smoke test with:

```powershell
Godot_v4.7-stable_win64.exe --headless --path C:\Users\User\one_flag_thailand --scene res://tests/SmokeTest.tscn
```
