extends Area2D
signal hit #pour emettre un signal (by le joueur) quand il cogne un ennemi

@export var speed = 400 # Vitesse de deplacement
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Initialisation de la taille de l'écran
	hide() # Pour ne pas afficher le joueur au depart du jeu
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Represente la vitesse & direction du joueur dans le plan
	# modification de la velocité selon la direction
	if Input.is_action_pressed("move_right") :
		velocity.x += 1
	if Input.is_action_pressed("move_left") :
		velocity.x -= 1
	if Input.is_action_pressed("move_up") :
		velocity.y -= 1
	if Input.is_action_pressed("move_down") :
		velocity.y += 1
		
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed # Pour avoir une valeur entre 0 et 1 multiply by speed
		# Au deplacement, on veut une animation
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if (velocity.x != 0) :
		$AnimatedSprite2D.animation = "walk" #Changement de l'animation
		$AnimatedSprite2D.flip_h = velocity.x < 0 # Le flip pour la tourner selon la direction sur l'horizontal
	elif (velocity.y != 0) :
		$AnimatedSprite2D.animation = "up" 


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
	
func start(pos) :
	position = pos
	show()
	$CollisionShape2D.disabled = false
