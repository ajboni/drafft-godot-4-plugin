@tool
extends EditorPlugin

var importer: DrafftImporter
const AUTOLOAD_NAME = "Drafft"

func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/drafft/drafft_importer.gd")

func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)

func _enter_tree():
	importer = DrafftImporter.get_instance() # Use static instance
	add_tool_menu_item("Reload Drafft DB", _on_reload_pressed)

func _exit_tree():
	remove_tool_menu_item("Reload Drafft DB")

func _on_reload_pressed():
	importer.reload()
	print("::DrafftPlugin:: Reloaded Drafft DB")

func get_db() -> DrafftImporter:
	return DrafftImporter.get_instance() # Always return static instance