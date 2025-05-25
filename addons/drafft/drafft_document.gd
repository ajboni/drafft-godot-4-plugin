@tool
extends Node
class_name DrafftDocument

# Unique identifier for the document
@export var id: String = ""

# Name of the script document, cant use name in godot.
@export var docName: String = ""

@export_multiline var content: String = ""

# The type of the document (e.g., "Script")
@export var type: String = ""

# ID of the parent document (if applicable)
@export var parent: String = ""

# Full path or identifier for the document within a structure
@export var path: String = ""

# Timestamp string of when the document was created
@export var created: String = ""

# Timestamp string of when the document was last modified
@export var modified: String = ""

# Comments associated with the document. Reserved for future use.
@export var comments: String = ""

# The collection the document belongs to
@export var collection: String = ""

# Boolean indicating if the document is locked
@export var locked: bool = false

# Identifier of who locked the document
@export var locked_by: String = ""

# An alias or alternative name for the document
@export var alias: String = ""

# Revision identifier for the document
@export var rev: String = ""

func _ready() -> void:
	var clickable = get_node("Sprite")
	print("clickable: ", clickable)
	if (clickable):
		clickable.clicked.connect(_on_click)

func _on_click() -> void:
	var _content = JSON.parse_string(content)
	print(_content.item.description)

func from_dict(dict: Dictionary) -> void:
	for prop in get_property_list():
			var prop_name = prop.name
			if dict.has(prop_name) and prop_name != "name" and prop_name != "content":
				# Use `set()` to assign property automatically
				set(prop_name, dict[prop_name])
				
	if dict.has("_id"):
			set("id", dict["_id"]) # Set the 'id' property of this resource)
			
	if dict.has("content"):
			set("content", JSON.stringify(dict.content, " ")) # Set the 'id' property of this resource)

	if dict.has("name"):
			set("docName", dict.name) # Set the 'id' property of this resource)
	
func from_drafft_document(doc: DrafftDocument) -> void:
	for prop in get_property_list():
		var prop_name = prop.name
		if doc.has(prop_name):
			# Use `set()` to assign property automatically
			set(prop_name, doc[prop_name])
		if doc.has("_id"): # Check if _id exists in the source dictionary
			set("id", doc["_id"]) # Set the 'id' property of this resource)
