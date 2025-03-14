extends Window

@onready var timer: Timer = $Timer
@onready var clock_digits: Label = $CenterContainer/ClockDigits

var popup_menu: PopupMenu = PopupMenu.new()
var is_dragging: bool = false
var drag_start_position: Vector2 = Vector2()
var drag_offset: Vector2 = Vector2()
var app_window: Window = null

var mouse_offset: Vector2 = Vector2()

func _ready() -> void:	
	timer.start()
	add_child(popup_menu)
	
	popup_menu.add_item("Color", 1) # ID 1 per "Color"
	popup_menu.add_item("Size", 2)  # ID 2 per "Size"
	popup_menu.add_item("Opacity", 3) # ID 3 per "Opacity"
	popup_menu.add_separator() # Aggiunge una linea di separazione
	popup_menu.add_item("Quit", 4)   # ID 4 per "Quit"
	
	popup_menu.id_pressed.connect(_on_popup_menu_id_pressed) # Connetti il segnale id_pressed del PopupMenu

func _on_timer_timeout() -> void:
	var s_current_time: String = Time.get_time_string_from_system()
	clock_digits.text = s_current_time
	print(s_current_time) 
 
func _on_clock_digits_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed: 
			popup_menu.popup(Rect2(position + Vector2i(event.position), Vector2(0, 0)))
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:			
			if get_visible_rect().has_point(event.position):
				is_dragging = true
				mouse_offset = event.position
		else:
			is_dragging = false
	if event is InputEventMouseMotion and is_dragging:
		position += Vector2i(event.position - mouse_offset)

func _on_popup_menu_id_pressed(menu_item_id: int) -> void:
	match menu_item_id:
		1: # "Color" selezionato
			change_color()
		2: # "Size" selezionato
			change_size()
			# Qui puoi aggiungere la logica per cambiare la dimensione del font (es. chiedendo un valore numerico)
		3: # "Opacity" selezionato
			change_opcity()
			# Qui puoi aggiungere la logica per cambiare l'opacità della Label (es. uno slider)
		4: # "Quit" selezionato
			print("Menu Item: Quit")
			get_tree().quit()
		_: # Nessun ID corrispondente (dovrebbe essere gestito solo se hai voci senza ID o errori)
			print("Menu Item sconosciuto selezionato.")

func change_color() -> void:
	print("Menu Item: Color")
	
func change_size() -> void:
	print("Menu Item: Size")

func change_opcity() -> void:
	print("Menu Item: Opacity")
	
func change_position() -> void:
	print("Menu Item: Position")
