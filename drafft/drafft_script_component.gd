# Add this at the top
@tool
extends Node
class_name DrafftScriptComponent

# Add a property to hold the selected document
@export var selected_document: String = ""

func _get_property_list() -> Array:
		var props = []
		props.append({
				"name": "select_drafft_document",
				"type": TYPE_BOOL,
				"usage": PROPERTY_USAGE_EDITOR,
				"hint": PROPERTY_HINT_NONE
		})
		return props

func _set(property, value):
		print("SET called with property:", property, "value:", value)
		if property == "select_drafft_document" and value:
				_show_document_picker()
				return true
		return false


func _show_document_picker():
		if not Engine.is_editor_hint():
				return
		# Show a popup or print available documents for now
		var doc_names = []

		if DrafftImporter.is_loaded():
			var quests = DrafftImporter.get_items()
			print("Quests:", quests)


		print("Available Drafft Documents:", doc_names)
		# You can implement a custom EditorPlugin for a real popup

# ...existing code...
