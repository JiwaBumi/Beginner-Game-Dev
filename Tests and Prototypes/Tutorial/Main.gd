extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	pass
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	pass


func _on_score_timer_timeout():
	score += 1
	pass

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var path_follow = PathFollow2D.new()
	path_follow.progress_ratio = randf()
	$MobPath.add_child(path_follow)

	# Set the mob's position to the current location along the path.
	mob.position = path_follow.get_position()

	# Set the mob's direction perpendicular to the path direction.
	var direction = path_follow.rotation + PI / 2
	mob.rotation = direction

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
