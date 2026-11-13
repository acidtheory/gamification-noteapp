extends Node
class_name Event

@export var id: String = "event_id"
@export var cooldown: float = 86400

func _ready() -> void:
	while User.event_data.is_empty():
		await get_tree().process_frame
	if not User.event_data.has(id): User.event_data[id] = {"last_triggered" : Time.get_unix_time_from_system()}

func _physics_process(_delta: float) -> void:
	if check_for_time_remaining() and check():
		User.event_data[id]["last_triggered"] = Time.get_unix_time_from_system()
		reward()

func check_for_time_remaining() -> bool:
	if not User.event_data.has(id) or not User.event_data[id].has("last_triggered"):
		return true
	var last_triggered = User.event_data[id]["last_triggered"]
	var time : float = Time.get_unix_time_from_system()
	if time - last_triggered < cooldown:
		return false
	return true

func check() -> bool:
	return true

func reward_if_check() -> void:
	if check(): reward()

func reward() -> void:
	pass
