# Breakable Toy Ideas

Idea 1

A simplified version of codenames that you can play online. The front-end would involve a good amount of react for all the game functionality while the back-end would probably have to rely on Socket.IO to allow for multiple players at once and the asymmetric nature of the game that requires 2 players to be team leaders and have access to a different screen than the rest of the players. IF I have time, I'd like to also add a chat feature so that played can communicate during the game.

A simple functionality that I can deploy early would be a codenames board generator that would randomly generate a 5 x 5 grid of words taken from some random word api and assign each word a value of red/blue/black or neutral.

As for crud implementation, I assume that my webapp would require user accounts that can be created, deleted, updated, and destroyed. I’m also thinking about adding an option to record users game histories (wins/losses/users played against/recent game results) if I need to add more crud functionality.




Idea 2
My second idea is a lot less fleshed out but I might have so interest in acquiring some demographic data through apis such as the UN DATA API and the GHO API and displaying it in some manner using D3 to create interactive maps. There’s an interesting statistic called Years of Life Lost (analyzed and calculated in this study http://www.thelancet.com/action/showFullTextImages?pii=S0140-6736%2814%2961682-2) that basically takes each country’s life expectancy and determines the primary cause of death prior to the countries life expectancy. I’d like to see if could find a way to display said data in an interactive map.
