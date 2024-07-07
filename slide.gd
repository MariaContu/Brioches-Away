extends Area2D

var tiles = []
var solved = []
var mouse = false

signal slide_solved

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9]
	solved = tiles.duplicate()
	shuffle_tiles()
	
func shuffle_tiles():
	var previous = 99
	var previous_1 = 98
	for t in range(0,80):
		var tile = randi() % 9
		if tiles[tile] != $Tile9 and tile != previous and tile != previous_1:
			var rows = int(tiles[tile].position.y / 50)
			var cols = int(tiles[tile].position.x / 50)
			check_neighbours(rows,cols)
			previous_1 = previous
			previous = tile
			

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var mouse_copy = mouse
		print(mouse.position)
		mouse = false
		var rows = int(mouse_copy.position.y / 50)
		var cols = int(mouse_copy.position.x / 50)
		check_neighbours(rows,cols)
		if tiles == solved:
			emit_signal("slide_solved")
			print("You win!")

func check_neighbours(rows, cols):
	var empty = false
	var done = false
	var pos = rows * 3 + cols
	while !empty and !done:
		var new_pos = tiles[pos].position
		if rows < 2:
			new_pos.y += 50
			empty = find_empty(new_pos,pos)
			new_pos.y -= 50
		if rows > 0:
			new_pos.y -= 50
			empty = find_empty(new_pos,pos)
			new_pos.y += 50
		if cols < 2:
			new_pos.x += 50
			empty = find_empty(new_pos,pos)
			new_pos.x -= 50
		if cols > 0:
			new_pos.x -= 50
			empty = find_empty(new_pos,pos)
			new_pos.x += 50
		done = true
			
func find_empty(position,pos):
	var new_rows = int(position.y / 50)
	var new_cols = int(position.x / 50)
	var new_pos = new_rows * 3 + new_cols
	if tiles[new_pos] == $Tile9:
		swap_tiles(pos, new_pos)
		return true
	else:
		return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile
	
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		mouse = event
