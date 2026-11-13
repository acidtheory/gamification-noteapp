extends Control

@onready var chapter_option: OptionButton = $MarginContainer/Content/Header/ChapterOption
@onready var content_editor: TextEdit = $MarginContainer/Content/ContentEditor

func _ready() -> void:
	if Notes.chapters.is_empty():
		_create_chapter()
		return

	if not Notes.chapters.has(Notes.current_chapter):
		Notes.current_chapter = Notes.chapters[0]

	_refresh_chapters()
	_load_current_chapter()

func _refresh_chapters() -> void:
	chapter_option.clear()
	for chapter in Notes.chapters:
		chapter_option.add_item(chapter)
	chapter_option.select(Notes.chapters.find(Notes.current_chapter))

func _load_current_chapter() -> void:
	content_editor.text = Notes.content.get(Notes.current_chapter, "")

func _create_chapter() -> void:
	var chapter_number := Notes.chapters.size() + 1
	var chapter_name := "Capitulo %d" % chapter_number
	while Notes.chapters.has(chapter_name):
		chapter_number += 1
		chapter_name = "Capitulo %d" % chapter_number

	Notes.chapters.append(chapter_name)
	Notes.content[chapter_name] = ""
	Notes.current_chapter = chapter_name
	_refresh_chapters()
	_load_current_chapter()
	Notes.new_chapter.emit()

func _on_chapter_option_item_selected(index: int) -> void:
	if index < 0 or index >= Notes.chapters.size():
		return

	Notes.current_chapter = Notes.chapters[index]
	_load_current_chapter()

func _on_new_chapter_pressed() -> void:
	_create_chapter()

func _on_content_editor_text_changed() -> void:
	if Notes.current_chapter.is_empty():
		return

	Notes.content[Notes.current_chapter] = content_editor.text
	Notes.text_changed.emit()
