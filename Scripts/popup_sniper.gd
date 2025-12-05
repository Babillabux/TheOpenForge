extends Control

var score = 0
var health = 3
var time_remaining = 180.0
var popup_scene = preload("res://Scenes/popup.tscn")
var popups = []

func _ready():
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	$SpawnTimer.start()

func _process(delta):
	time_remaining -= delta
	if time_remaining <= 0:
		game_over()
	update_ui()

func update_ui():
	$ScoreLabel.text = "Score : " + str(score)
	$HealthLabel.text = "Vie : " + str(health)
	var minutes = floor(time_remaining / 60)
	var seconds = int(time_remaining) % 60
	$TimerLabel.text = "%d:%02d" % [minutes, seconds]

func spawn_popup():
	var popup = popup_scene.instantiate()
	popup.position = Vector2(
		randf_range(50, get_viewport_rect().size.x - 250),
		randf_range(50, get_viewport_rect(). size.y - 150)
	)
	popup.closed.connect(_on_popup_closed)
	popup.baited.connect(_on_popup_baited)
	add_child(popup)
	popups.push_front(popup)

func _on_spawn_timer_timeout():
	spawn_popup()

func _on_popup_closed():
	score += 1
	$SpawnTimer.wait_time /= 1.025
	$SpawnTimer.wait_time = max($SpawnTimer.wait_time, 0.2)

func _on_popup_baited():
	health -= 1
	if health == 0:
		game_over()
	update_ui()

func game_over():
	for popup in popups:
		if popup != null:
			popup.queue_free()
	get_tree().paused = true
