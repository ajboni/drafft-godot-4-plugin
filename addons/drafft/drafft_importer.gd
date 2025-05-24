extends Node
class_name DrafftImporter

# Static instance for global access
static var _instance: DrafftImporter

var dbLoaded := false

var contents: Dictionary = {}
var meta: Dictionary = {}
var gdds: Array = []
static var scripts: Array[DrafftScript] = []
var dialogues: Array = []
var quests: Array = []
var items: Array = []
var grids: Array = []
var kanban: Array = []
var dbPath: String = ProjectSettings.get_setting("application/drafft/db_path")

func _ready():
	_instance = self # Set static reference
	reload()

# Static accessor methods
static func get_instance() -> DrafftImporter:
	if not _instance:
		# Create instance if it doesn't exist (for tool scripts)
		_instance = DrafftImporter.new()
		_instance.reload()
	return _instance

# Convenient static getters for common data
static func get_scripts() -> Array[DrafftScript]:
	return scripts

static func get_items() -> Array:
	var instance = get_instance()
	return instance.items if instance else []

static func get_quests() -> Array:
	var instance = get_instance()
	return instance.quests if instance else []

static func get_dialogues() -> Array:
	var instance = get_instance()
	return instance.dialogues if instance else []

static func get_gdds() -> Array:
	var instance = get_instance()
	return instance.gdds if instance else []

static func get_grids() -> Array:
	var instance = get_instance()
	return instance.grids if instance else []

static func get_kanban() -> Array:
	var instance = get_instance()
	return instance.kanban if instance else []

static func get_metadata() -> Dictionary:
	var instance = get_instance()
	return instance.meta if instance else {}

static func is_loaded() -> bool:
	var instance = get_instance()
	return instance.dbLoaded if instance else false

# Static reload method
static func reload_database():
	var instance = get_instance()
	if instance:
		instance.reload()

func reload():
	load_from_file(dbPath)

func load_from_file(path: String) -> void:
	if not FileAccess.file_exists(path):
		push_error("::Drafft:: File not found: %s" % path)
		return

	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("::Drafft:: Could not open file: %s" % path)
		return

	var json_str := file.get_as_text()

	var json = JSON.parse_string(json_str)
	if !json:
		push_error("::Drafft:: Invalid JSON: %s" % json.error_string)
		return

	contents = json
	meta = json.get("_meta", {})
	gdds = json.get("gdds", [])
	# Get the raw scripts array (of dictionaries) first
	var raw_scripts: Array = json.get("scripts", [])
	dialogues = json.get("dialogues", [])
	quests = json.get("quests", [])
	items = json.get("items", [])
	grids = json.get("grids", [])
	kanban = json.get("kanban", [])

	# --- Convert raw script dictionaries to ScriptDocument objects ---
	var processed_scripts: Array[DrafftScript] = []
	for raw_script_dict in raw_scripts:
		var script_doc = DrafftScript.new()
		script_doc.from_dict(raw_script_dict)
		processed_scripts.append(script_doc)

	# Assign the array of ScriptDocument objects to the typed variable
	self.scripts = processed_scripts
	# --- End of conversion ---

	if meta.has("drafftVersion"):
		print("::Drafft:: Database loaded")
		print("::Drafft:: Export Version:", meta.drafftVersion)
		# Use the size of the processed_scripts array for the summary
		print("::Drafft:: Summary: GDDs: %d, Scripts: %d, Dialogues: %d, Quests: %d, Items: %d, Grids: %d, Kanban: %d" % [gdds.size(), scripts.size(), dialogues.size(), quests.size(), items.size(), grids.size(), kanban.size()])
		dbLoaded = true
	else:
		print("Failed to load Drafft database")