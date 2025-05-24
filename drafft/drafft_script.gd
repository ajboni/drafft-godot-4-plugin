extends DrafftDocument
class_name DrafftScript

# Content of the script (likely the script text itself)
@export var content: Dictionary = {"script": ""}

# Mode for the script editor (e.g., "text")
@export var script_editor_mode: String = ""

# Boolean indicating if this is a dialogue script
@export var is_dialogue_script: bool = false

# Generic editor mode (e.g., "text")
@export var editor_mode: String = ""
