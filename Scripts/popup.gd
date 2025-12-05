extends Panel

signal closed
signal baited

const texts = [
	"Offre limitée !",
	"-50 % aujourd’hui seulement",
	"Ne manque pas cette promo",
	"Dernières pièces disponibles",
	"Clique ici pour en profiter",
	"Fais vite, ça part vite !",
	"Exclusivité web",
	"Tu as été sélectionné !",
	"Découvre notre nouveau produit",
	"Livraison gratuite dès maintenant",
	"Une surprise t’attend",
	"Réduction immédiate",
	"Profite-en avant la fin",
	"Essaye gratuitement",
	"Deal du jour",
	"Offre spéciale pour toi",
	"Ajoute au panier avant rupture",
	"Meilleur prix garanti",
	"Promotion exceptionnelle",
	"Cadeau offert avec ta commande"
]

var text = texts[randi_range(0, len(texts) - 1)];
var bait = randi_range(0, 10) == 0

func _ready():
	$Label.text = text
	$Button.text = "Ouvrir" if bait else "Fermer"
	$Button.focus_mode = Control.FOCUS_NONE
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if bait:
		baited.emit()
	else:
		closed.emit()
	queue_free()
