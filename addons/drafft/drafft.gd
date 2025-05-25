@tool
extends EditorPlugin

const AUTOLOAD_NAME = "Drafft"
var importer: DrafftImporter
var inspector_plugin := preload("res://addons/drafft/drafft_document_inspector.gd").new()

func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/drafft/drafft_importer.gd")

func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)

func _enter_tree():
	importer = DrafftImporter.get_instance() # Use static instance
	add_inspector_plugin(inspector_plugin)
	add_tool_menu_item("Reload Drafft DB", _on_reload_pressed)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_tool_menu_item("Reload Drafft DB")

func _on_reload_pressed():
	importer.reload()
	print("::DrafftPlugin:: Reloaded Drafft DB")

func get_db() -> DrafftImporter:
	return DrafftImporter.get_instance() # Always return static instance