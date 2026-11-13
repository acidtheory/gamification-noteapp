extends VBoxContainer

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var achievement_list: VBoxContainer = $PanelContainer/VBoxContainer/AchievementList
@onready var exp_bar: ProgressBar = $ExpBar
@onready var streak_label: Label = $VBoxContainer/StreakLabel

func _ready() -> void:
	update_player_data()

func _process(delta: float) -> void:
	update_player_data()

func update_player_data() -> void:
	name_label.text = User.username
	level_label.text = "Nivel %d" % User.level

	for child in achievement_list.get_children():
		child.queue_free()

	for achievement in User.achievements:
		var achievement_label := Label.new()
		achievement_label.text = achievement
		achievement_list.add_child(achievement_label)

	exp_bar.value = User.experience
	exp_bar.max_value = User.get_experience_for_next_level()
	
	streak_label.text = "Streak %s" % User.streak
