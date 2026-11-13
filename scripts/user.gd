extends Node

var username: String = "Facu"
var level: int = 1
var streak: int = 0
var experience: int = 0
var achievements: Array = []
var event_data : Dictionary = {}

func save_data() -> void:
	var user_data = {
		"username": username,
		"level": level,
		"experience": experience,
		"achievements": achievements,
		"event_data" : event_data,
		"chapters" : Notes.chapters,
		"content" : Notes.content
	}
	
	var file = FileAccess.open("user://user_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(user_data))

func load_data() -> void:
	if FileAccess.file_exists("user://user_data.json"):
		var file = FileAccess.get_file_as_string("user://user_data.json")
		var data = JSON.parse_string(file)
		username = data.get("username", username)
		level = data.get("level", level)
		experience = data.get("experience", experience)
		achievements = data.get("achievements", achievements)
		event_data = data.get("event_data", event_data)
		Notes.chapters = data.get("chapters", Notes.chapters)
		Notes.content = data.get("content", Notes.content)
	else:
		event_data = {
			"streak_manager" : {"streak_start" : Time.get_unix_time_from_system(), "last_triggered" : Time.get_unix_time_from_system()}
				}

func add_experience(amount: int) -> void:
	experience += amount
	while experience >= get_experience_for_next_level():
		experience -= get_experience_for_next_level()
		print(get_experience_for_next_level())
		level += 1
		level_up_sound.play()

func get_experience_for_next_level() -> int:
	return int(ceil(20.0 * log(float(level + 1)) / log(2.0)))

func _ready() -> void:
	load_data()
	load_achievement_sound()
	load_level_up_sound()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		event_data["streak_manager"]["last_triggered"] = Time.get_unix_time_from_system()
		save_data()

func add_achievement(achievement: String) -> void:
	if achievement not in achievements:
		achievements.append(achievement)
		achievement_sound.play()

@onready var level_up_sound : AudioStreamPlayer = AudioStreamPlayer.new()
func load_level_up_sound():
	add_child(level_up_sound)
	level_up_sound.stream = preload("res://assets/audio/level_up.mp3")

@onready var achievement_sound : AudioStreamPlayer = AudioStreamPlayer.new()
func load_achievement_sound():
	add_child(achievement_sound)
	achievement_sound.stream = preload("res://assets/audio/achievement.mp3")
