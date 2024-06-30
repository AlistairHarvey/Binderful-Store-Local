# Binderful-Store-Local
Binderful Store Local is a management system for uploading TCG cards to a Shopify Store via building a CSV to upload product information.

# Overview
I run a online TCG store where i mainly sell Pokemon TCG singles, for this i use a shopify website due to how quick and easy it is to get a functioning website complete with everything you need! The main issue is building stock. When selling cards there can be hundreds of listings, mainly generic. For example when the last set came out, that meant about 30 product listings needed to me made using pretty cookie cutter information. So instead of duplicating products, finding images, finding the price, writing the title and description all i do is use this app. 

# How it works with Shopify
Shopify allows the uploading of inventory through a CSV file as long as it is formatted correctly. The unique information i need is the title, price, quantity, images and description. The rest is pretty default. So this app builds a CSV to export, which is then uploaded to shopify. 

Firstly you search a card using its unique number, which is a combination of card number and set printed total number i.e 222/193. I search my own database for this card, which then pulls down the Tyranitar from the set Paldea Evolved with its last updated pricing information. I can then add the card to an in memeory list, thats maintained until its exported to an excel document allowing changes to be made. 

# Card Data
Card data comes from an API called PokemonTCGAPI, which has a database of every single english pokemon card ever made. I hit this API to check for new sets, to check I have all the cards from the set (promo cards get added all the time) and to see if I have the card data. When a new set is found from this API i pull the data, and pass it to my own DB model in a Raven DB. This allows me to reduce the amount of time I am hitting the PokemonTCGAPI for data, and moves the burden to my own system while allowing me to store the data as i need it. 

This data also includes generic card images that can be used as well as all the information needed to create a listing apart from the price.

# Pricing Data
PokemonTCGAPI is maintianed in the US, meaining the pricing data they pull in is specific to the US. We have a different market over here, very similar in most cases but for selling cards, more acurate data is best. The first iteration used PokePrice.IO which allowed direct unlimited price checks so i could price on the fly while i added cards. As typically 30 cards a time, this worked well. This company unfortunately decided to stop working so i switched to PokeCardValues, which is also a UK based site that collects pricing information from ebay. The issue here is no API's so i had to web scrape the pricing data. Due to the extra complexity of this, i added the pricing data in my own models to the database. 

Now pricing is down per set on demand, i added a new screen to the add to check my database had all the latest sets, and if missing upload them and the respective cards, then i added the ability to add UK pricing through the above method. This will eventually be done in the background periodically, picking the least up to date sets and updating the pricing info as needed, with newer sets updating more frequently.

Now the card and pricing data from the card uploading screen is done completely on my own systems, through my own local database containing over 17,000 cards, pulling information into a spread sheet and making a multiple hour job into a 5 minute job. 

# Future work. 
I am migrating this app to a Shopify app, which means moving the front end to another framework so it can integrate into the shopify ecosystem. This front end will continue to be maintained as my testing ground. The next major piece of work is moving the pricing updating to a API function that checks daily for 5 sets to update on various conditions to not overload PokeCardValues. Then pricing maintainance will be added, where a user can import their shopify inventory and it will check the database prices against the inventory prices, updating the prices that are out of range while giving the user the option to make changes before uploading the new prices to shopify. 

# Other points of interest 
I did toy around with uploading sealed products from email data thats canvased out to stores, this proved to be rather chaotic so I have shelved this for the time being but for the most case, it proved to be possible. 

