extends Node2D

var player 
var top_down
var side_scroll
var mode

func _ready():
	player = $Player
	top_down = $Player/TopDown
	side_scroll = $Player/SideScroll
	
	top_down.make_current()
	mode = top_down
	
func _process(_delta):
	if Input.is_action_just_pressed("switch"):
		switch_mode()

func switch_mode():
	if mode == top_down:
		side_scroll.make_current()
		mode = side_scroll
		player.set_mode(player.Mode.SIDE_SCROLL)
	elif mode == side_scroll:
		top_down.make_current()
		mode = top_down
		player.set_mode(player.Mode.TOP_DOWN)
