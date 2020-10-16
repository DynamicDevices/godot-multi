extends Node2D

var move_speed = 300

slave var repl_position = Vector2()

func set_dominant_color(color):
	$icon.modulate = color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_network_master()):
		# Initialize the movement vector
		var move_dir = Vector2(0, 0)
	
		# Poll the actions keys
		if (Input.is_action_pressed("move_up")):
			# Negative Y will move the actor UP on the screen
			move_dir.y -= 1
		if (Input.is_action_pressed("move_down")):
			# Positive Y will move the actor DOWN on the screen
			move_dir.y += 1
		if (Input.is_action_pressed("move_left")):
			# Negative X will move the actor LEFT on the screen
			move_dir.x -= 1
		if (Input.is_action_pressed("move_right")):
			# Positive X will move the actor RIGHT on the screen
			move_dir.x += 1
		
		# Apply the movement formula to obtain the new actor position
		position += move_dir.normalized() * move_speed * delta

		# Replicate the position
		rset("repl_position", position)
	else:
		# Take replicated variables to set current actor state
		position = repl_position	
