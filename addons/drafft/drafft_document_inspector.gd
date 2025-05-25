# res://addons/drafft_document_inspector/drafft_document_inspector.gd
extends EditorInspectorPlugin

# Reference to your DB. Replace this with how you actually access it.
var db: DrafftImporter

func _can_handle(object: Object) -> bool:
	# Check if the object is a DrafftDocument
	return object is DrafftDocument

func _parse_begin(object: Object) -> void:
	# Add a button to the inspector
	var button = Button.new()
	button.text = "Fill from DB"
	button.pressed.connect(_on_fill_pressed.bind(object))
	add_custom_control(button)

func _on_fill_pressed(doc: DrafftDocument):
	if doc.id == "":
		push_error("No ID set in the document!")
		return
	var data = DrafftImporter.get_document(doc.id)

	if data:
		# Fill the document with the data from the DB, which is a drafft document
		for prop in data.get_property_list():
			var prop_name = prop.name
			if (data.get(prop_name)):
				doc.set(prop_name, data[prop_name])
			if data.get("_id"): # Check if _id exists in the source dictionary
					doc.set("id", data["_id"]) # Set the 'id' property of this resource)
		print("::Drafft:: Document with ID '%s' found in DB. Filled with data." % doc.id)

	else:
		push_error("::Drafft:: Document with ID '%s' not found in DB." % doc.id)
