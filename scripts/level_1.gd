extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Tree 1
	var sprite3d = Sprite3D.new()
	sprite3d.texture = load("res://assets/terrain/palm_tree.png")
	sprite3d.pixel_size = 0.0625
	sprite3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite3d.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite3d.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	add_child(sprite3d)
	sprite3d.position = Vector3(2.0 , 4.06, 2.0)
	#Tree 2
	var palm_tree = Sprite3D.new()
	palm_tree.texture = load("res://assets/terrain/palm_tree.png")
	palm_tree.pixel_size = 0.0625
	palm_tree.scale = Vector3(1.2, 1.2, 1.2)
	palm_tree.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	palm_tree.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	palm_tree.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	palm_tree.flip_h = true
	add_child(palm_tree)
	palm_tree.position = Vector3(12.0 , 4.06, 2.0)
	#Tree 3
	var palm_tree3 = Sprite3D.new()
	palm_tree3.texture = load("res://assets/terrain/palm_tree.png")
	palm_tree3.pixel_size = 0.0625
	palm_tree3.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	palm_tree3.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	palm_tree3.rotation.z = PI/12
	add_child(palm_tree3)
	palm_tree3.position = Vector3(16.0 , 4.06, 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
