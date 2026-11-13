extends Event

func _ready() -> void:
	super._ready()
	Notes.new_chapter.connect(reward_if_check)

func check() -> bool:
	return Notes.chapters.size() >= 10

func reward() -> void:
	User.add_achievement("Narrador")
