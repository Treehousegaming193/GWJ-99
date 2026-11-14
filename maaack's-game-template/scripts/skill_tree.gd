extends Control

#How to make the skill tree work inside of godot!

#In yggdrasil_allocation_service script change can_purchase_upgrade to func can_purchase_upgrade(node: YggdrasilNodeButton) -> bool
@export var tree_parent = self

#Set the tree view
var tree_view: YggdrasilTreeView

#create skill points variable
@export var skill_point : int = 2

#defining different colours used
const AFFORDABLE_ICON_COLOUR := Color.YELLOW
const UNAFFORDABLE_ICON_COLOUR := Color("555555")
const PURCHASED_ICON_COLOUR := Color.GREEN

var restoring_saved_tree: bool = false

var all_tree_nodes: Array[YggdrasilNodeButton] = []

var health = 5
var damage = 1

func _ready() -> void:
	#define the specific tree
	var tree: YggdrasilTree = YggdrasilLoader.load_tree("Skill_tree/Skills_1")
	#define builder
	var builder := YggdrasilBuilder.new(tree)
	#aasign builder variables
	builder.set_parent(self)
	
	#recives the node that is clicked
	builder.allocation_check_callback(can_purchase_node)
	
	#Blocks refunds
	builder.deallocation_check_callback(never_allow_deallocation)
	
	#logs every node created in the array
	builder.node_created_callback(_on_node_created)
	
	#runs the functions
	builder.node_allocated_callback(_on_node_allocated)
	builder.node_deallocated_callback(_on_node_deallocated)
	tree_view = builder.build()
	#ensures skill points aren't sent while building
	restoring_saved_tree = false
	#make sure to calculate
	recalculate_skill_effects()
	refresh_all_node_icons()

#adds created node to the array defined earlier
func _on_node_created(node: YggdrasilNodeButton) -> void:
	all_tree_nodes.append(node)
	update_node_icon_colour(node)

#func to 
func update_node_icon_colour(node: YggdrasilNodeButton) -> void:
	var icon := node.get_node_or_null("Icon") as CanvasItem

	if icon == null:
		return

	if node.allocated:
		icon.self_modulate = PURCHASED_ICON_COLOUR
	elif skill_point != null and skill_point >= get_node_cost(node):
		icon.self_modulate = AFFORDABLE_ICON_COLOUR
	else:
		icon.self_modulate = UNAFFORDABLE_ICON_COLOUR

#refreshes the colours
func refresh_all_node_icons() -> void:
	for node in all_tree_nodes:
		if is_instance_valid(node):
			update_node_icon_colour(node)

#func to allocate nodes - sends details and adjusts the effects
func _on_node_allocated(node: YggdrasilNodeButton) -> void:
	print("Node name: ", node.node_name)
	print("External ID: ", node.external_id)
	print("Node ID: ", node.id)
	print("Attributes: ", node.attributes)
	print(node.node_name, " costs ", get_node_cost(node), " skill points")
	#changes the color when clicked
	var icon := node.get_node("Icon") as TextureRect
	icon.modulate = Color.GREEN
	if not restoring_saved_tree:
		var cost := get_node_cost(node)
		skill_point -= cost
		print("Spent ", cost, " point(s). Remaining: ", skill_point)
	recalculate_skill_effects()

func _on_node_deallocated(node: YggdrasilNodeButton) -> void:
	print("Deallocated: ", node.node_name, " ID: ", node.id)
	var icon := node.get_node("Icon") as TextureRect
	icon.modulate = Color.WHITE
	recalculate_skill_effects()

func _on_tree_changed(_node: YggdrasilNodeButton) -> void:
	recalculate_skill_effects()

func recalculate_skill_effects() -> void:
	if not is_instance_valid(tree_view):
		return

	#set bonuses
	var health_bonus := 0

	for node_id in tree_view.allocation_service._allocated_nodes:
		var node := tree_view.nodes_service.get_node(node_id)

		#for each if statement: external_id = name
		#atribute value is name
		if node.external_id == "Node_1":
			health_bonus += get_attribute_value(node, "health")
			print(get_attribute_value(node, "health"))
		
			
	#assign changes
	health = 5 + health_bonus

#grabs the values
func get_attribute_value(node: YggdrasilNodeButton, attribute_id: String) -> int:
	if not node.attributes.has(attribute_id):
		return 0

	var values: Array = node.attributes[attribute_id]
	if values.is_empty():
		return 0

	return int(values[0])

#grabs the cost of a node
func get_node_cost(node: YggdrasilNodeButton) -> int:
	if not node.attributes.has("cost"):
		push_warning("Node has no skill_point_cost attribute: " + node.node_name)
		return 0

	var values: Array = node.attributes["cost"]

	if values.is_empty():
		return 0

	return int(values[0])

#checks currency can buy the node
func can_purchase_node(node: YggdrasilNodeButton) -> bool:

	var cost := get_node_cost(node)

	print("Trying to buy ", node.node_name, " for ", cost, " skill point(s)")

	if skill_point < cost:
		print("Not enough skill points.")
		return false

	return true
	
#stops the refund
func never_allow_deallocation() -> bool:
	return false
	
#debug
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print("Health bonus = "+str(health))
		print("Damage bonus = "+str(damage))
