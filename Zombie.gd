extends KinematicBody

const MOVE_SPEED = 3

onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer

var player = null
var dead = false

func _ready():
	anim_player.play("walk")
	add_to_group("zombies")

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
	
	var vec_to_player = player.translation - translation
	vec_to_player = vec_to_player.normalized()
	raycast.cast_to = vec_to_player * 1.5
	
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()

func kill():
	dead = true
	$CollisionShape.disabled = true
	anim_player.play("die")

func set_player(p):
	player = p