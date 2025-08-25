extends CharacterBody2D

var speed = 100
@onready var target : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
var hp = 1000
