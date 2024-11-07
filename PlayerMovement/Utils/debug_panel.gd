extends PanelContainer

@onready var property_container = %VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.debug = self # Assegna la reference al Global
	visible = false

func _process(_delta):
	if !visible:
		return
	
	var frames_per_second = Engine.get_frames_per_second() # Uguale a "%.2f" % (1.0/delta)
	add_property("FPS", frames_per_second, 0)

func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible

func add_property(title: String, value, order):
	var target #Conterrà la nuova label da mettere nel pannello
	target = property_container.find_child(title, true, false) # Vediamo se già esiste una label identica
	if !target: # Se non esiste viene aggiunta al pannello
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible: # Se esiste cambio il valore, mantengo il nome e la sposto nell'ordine specificato
		target.text = target.name + ": " + str(value)
		property_container.move_child(target, order) # Se order è negativo verrà messo all'ultimo posto

