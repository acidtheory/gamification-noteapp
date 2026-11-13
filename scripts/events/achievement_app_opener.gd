extends Event

func reward() -> void:
	User.add_achievement("App Opener")
	queue_free()
