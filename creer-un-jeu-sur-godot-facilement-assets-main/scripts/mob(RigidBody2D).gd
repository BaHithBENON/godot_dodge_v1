extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() # recuperer les animations avec les noms
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()]) # choisi une animation aleatoirement (ennemi au hasard)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # destruction de l'objet en s'aasurant que n'est pas utiliser ailleurs.
