extends Node

var streak_time : float = 86400

func _ready() -> void:
	while User.event_data.is_empty():
		await get_tree().process_frame
	var last_triggered : float = User.event_data["streak_manager"]["last_triggered"]
	var time : float = Time.get_unix_time_from_system()
	if time - last_triggered > streak_time:
		User.streak = 0
		User.event_data["streak_manager"]["streak_start"] = time

func _physics_process(_delta: float) -> void:
	var streak_start : float = User.event_data["streak_manager"]["streak_start"]
	var time : float = Time.get_unix_time_from_system()
	if time - streak_start > streak_time:
		User.streak += 1
		User.event_data["streak_manager"]["streak_start"] = time
