extends Control

#player
var player_count_label: Label
var player_cards_container: HBoxContainer
var player_cards: Array[int]
var player_count: int:
	get:
		var value: int = 0
		for card: int in player_cards:
			if card > 9:
				value += 10
			else:
				value += card
		return (value)

#dealer
var dealer_count_label: Label
var dealer_cards_container: HBoxContainer
var dealer_cards: Array[int]
var dealer_count: int:
	get:
		var value: int = 0
		for card: int in dealer_cards:
			if card > 9:
				value += 10
			else:
				value += card
		return (value)

#global
var state_label: Label
var draw_button: Button
var stay_button: Button

var rng = RandomNumberGenerator.new();

func _ready() -> void:
	#player
	player_count_label = $PlayerCount
	player_cards_container = $PlayerCardsContainer
	#dealer
	dealer_count_label = $DealerCount
	dealer_cards_container = $DealerCardsContainer
	#global
	state_label = $State
	draw_button = $DrawButton
	stay_button = $StayButton
	draw_button.pressed.connect(player_draw)
	stay_button.pressed.connect(stay)
	
	player_draw()
	update_game()
	pass

func update_game() -> void:
	dealer_draw()
	if player_count >= 21 || dealer_count >= 21:
		end()
	pass

func stay() -> void:
	while dealer_count < 17:
		dealer_draw()
	end()
	pass

func end() -> void:
	if player_count == dealer_count || (player_count > 21 && dealer_count > 21):
		state_label.text = "DRAW"
	else: if (player_count == 21 && dealer_count != 21) || (player_count < 21 && dealer_count > 21) || (player_count > dealer_count && player_count <= 21):
		state_label.text = "WIN"
	else:
		state_label.text = "LOSER"
	draw_button.pressed.disconnect(player_draw)
	stay_button.pressed.disconnect(stay)
	draw_button.visible = false
	stay_button.visible = false
	pass

func player_draw() -> void:
	draw_card(player_cards, player_cards_container)
	player_count_label.text = "Me : " + str(player_count)
	update_game()
	pass

func dealer_draw() -> void:
	if (dealer_count < 17):
		draw_card(dealer_cards, dealer_cards_container)
		dealer_count_label.text = "Dealer : " + str(dealer_count)

func draw_card(cards: Array[int], container: HBoxContainer) -> void:
	var value: int = rng.randi_range(1, 13)
	cards.append(value)
	var card = load("res://Scenes/BlackJack/card.tscn").instantiate()
	container.add_child(card)
	card.init(value)
	pass
