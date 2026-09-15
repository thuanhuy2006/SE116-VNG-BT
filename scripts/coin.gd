extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite3D.play("default")
	body_entered.connect(_on_body_entered)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node3D) -> void:
	$Coin.play()
	$AnimatedSprite3D.play("disapear")
	await $AnimatedSprite3D.animation_finished
	queue_free()
	
