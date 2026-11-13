extends Event

func _ready() -> void:
	super._ready()
	Notes.new_chapter.connect(reward_if_check)

func check() -> bool:
	for chapter in Notes.content:
		if Notes.content[chapter].length() < 240: return false
	return true

func reward() -> void:
	User.add_experience(10)
