extends EnemyAction

func action():
	unit.target.current_health -= 1
