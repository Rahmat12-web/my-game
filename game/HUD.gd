extends CanvasLayer

var coins = 0

func _ready():
	$Count.text = String(coins)


func _on_coin_collected():
	coins = coins + 1
	_ready()
