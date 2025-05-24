extends Node
class_name DrafftDocument

# Unique identifier for the document
@export var id: String = ""

# Name of the script document
@export var docName: String = ""

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

func from_dict(dict: Dictionary) -> void:
		for prop in get_property_list():
				var prop_name = prop.name
				if dict.has(prop_name):
					# Use `set()` to assign property automatically
					set(prop_name, dict[prop_name])
				if dict.has("_id"): # Check if _id exists in the source dictionary
					set("id", dict["_id"]) # Set the 'id' property of this resource)
