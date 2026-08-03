extends Node

@onready var pipes: Node = $"."

signal death
signal dash
signal dash_stop
signal point_add

var first_play = true
var score = 0
var high_score = 0
