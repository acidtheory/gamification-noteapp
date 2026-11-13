extends Event

func _ready() -> void:
	super._ready()
	Notes.text_changed.connect(reward)

func reward() -> void:
	User.add_experience(1)
	print("app_opened_exp_reward")
