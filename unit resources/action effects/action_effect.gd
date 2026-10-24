class_name ActionEffect
extends Resource

@export var instant: bool = true
@export var modified_attribute: String
@export var modify_value: float

func apply_effect(target:BattleUnit):
	target.set(modified_attribute, target.get(modified_attribute) + modify_value)
