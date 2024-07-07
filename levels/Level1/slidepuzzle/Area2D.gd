extends Area2D

var tiles = []
var solved = []
var mouse = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Game Ready")
	start_game()

func start_game():
	tiles = [$tile1, $tile2, $tile3, $tile4, $tile5, $tile6, $tile7, $tile8, $tile0]
	solved = tiles.duplicate()
	shuffle_tiles()
	print("Game Started")

func shuffle_tiles():
	var previous = 99
	var previous_1 = 98
	for t in range(0, 100):
		var tile = randi() % 9
		if tiles[tile] != $tile0 and tile != previous and tile != previous_1:
			var rows = int(tiles[tile].position.y / 250)
			var cols = int(tiles[tile].position.x / 250)
			check_neighbours(rows, cols)
			previous_1 = previous
			previous = tile
	print("Tiles Shuffled")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse and mouse.button_index == MOUSE_BUTTON_LEFT and mouse.pressed:
		var mouse_copy = mouse
		print("Mouse Position: ", mouse_copy.position)
		mouse = null
		var rows = int(mouse_copy.position.y / 250)
		var cols = int(mouse_copy.position.x / 250)
		check_neighbours(rows, cols)
		if tiles == solved:
			print("You win!")

func check_neighbours(rows, cols):
	var empty = false
	var done = false
	var pos = rows * 3 + cols
	while not empty and not done:
		var new_pos = tiles[pos].position
		if rows < 2:
			new_pos.y += 250
			empty = find_empty(new_pos, pos)
			new_pos.y -= 250
		if rows > 0:
			new_pos.y -= 250
			empty = find_empty(new_pos, pos)
			new_pos.y += 250
		if cols < 2:
			new_pos.x += 250
			empty = find_empty(new_pos, pos)
			new_pos.x -= 250
		if cols > 0:
			new_pos.x -= 250
			empty = find_empty(new_pos, pos)
			new_pos.x += 250
		done = true

func find_empty(position, pos):
	var new_rows = int(position.y / 250)
	var new_cols = int(position.x / 250)
	var new_pos = new_rows * 3 + new_cols
	if tiles[new_pos] == $tile0:
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
	print("Tiles Swapped: ", tile_src, tile_dst)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		mouse = event
		print("Mouse Button Event: ", event)
