extends Event

func reward() -> void:
	User.add_experience(1)
	print("app_opened_exp_reward")
