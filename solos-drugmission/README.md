# Simple Mission Script for players to get access to an illegal shop!
- Configure Locations, Items, Prices, Amounts, and more. 

- https://i.imgur.com/hmYxCK1.jpeg 
- https://i.imgur.com/nOtZ8wA.jpeg
- https://i.imgur.com/wJghfKc.jpeg

# Add the following to /qb-core > /shared > items.lua

	['mission_breifcase'] 			 = {['name'] = 'mission_breifcase', 			['label'] = 'Brief Case', 				['weight'] = 200, 	    ['type'] = 'item', 		['image'] = 'mission_breifcase.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Do I even bother looking inside?'},

# Add Image from /assets to inventory images 

/qb-inventory > /html > /images

# Add / Remove options in config.lua table named "config.ingredients"

These are already configured to 'Solos Drugs', however, you can add or remove options as you'd like if you're using other resources. 

# Solos (QB-CORE) Drug Scripts: 

--- https://shop.solosv.com/category/2347542 ---

- Meth Lab
- Coke Lab
- Weed Warm 
- XTC Craft
- Molly Craft

Bundles and Subscription Plans available.

# For Questions / Support:

https://discord.com/invite/UNbCJUrncS
