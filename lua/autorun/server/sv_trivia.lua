--[[ 

TrivaBot by Zero The Fallen
Randomly made
Have fun :V

]]--

print("Trivia Bot Loading...")

local red = Color(255, 0, 0, 255)
local blue = Color(0, 0, 255, 255)
local green = Color(0, 255, 0, 255)
local pink = Color(255, 0, 255, 255)
local yellow = Color(255, 255, 0, 255)
local pink = Color(255, 0, 255, 255)
local purple = Color(155, 0, 255, 255)
local white = Color(255, 255, 255, 255)
util.AddNetworkString("ChatBot")

//Config
local botname = "Trivia Bot"
local GivePSPoints = false
local PSPointsAmount = 15
local QuestionInterval = 5
local SpectatorOnly = false


local StartMessage = { red, "[", blue, botname, red, "]", white, " The trivia game has started! Type trivfaq for more info!"}
local EndMessage = { red, "[", blue, botname, red, "]", white, " The trivia game has ended. See you next time!"}
local QInProgress = { red, "[", blue, botname, red, "]", white, " Question currently in progress!"}
local AnswerG = {}
local PPoints = {}
local Faq = {red, "[", blue, botname, red, "]", white, " The commands are auto, autooff, points, again to hear it again, a for the answer, q for another question (auto mode off)!"}
local Empty = {red, "[", blue, botname, red, "]", white, " There is currently no question as of now!"}
local AutoOn = {red, "[", blue, botname, red, "]", white, " Automatic Trivia Mode Activated."}
local AutoOff = {red, "[", blue, botname, red, "]", white, " Automatic Trivia Mode deactivated."}
local Answered = {}
local lol = {}
local lols = {}


local trivia = false // Trivia isnt in progress
local QP = false     // No Question is currently going.
local auto = false   // Automatic question mode?
local winner = nil   // Who is the winner?

local QaA = {
	{q = "2+2?", a = "4"},
	{q = "5+2?", a = "7"},
	{q = "1*0+3", a = "3"},
	{q = "0+0?", a = "0"},
	{q = "Who is the main character of Code Geass? (First Name)", a = "Lelouch"},
	{q = "Capital of USA?", a = "Washington D.C"},
	{q = "First Black President of USA?", a = "Barack Obama"},
	{q = "How many shoes does a human wear?", a = "2"},
	{q = "Does an anonymous function have an indentifier?", a = "no"},
	{q = "y = (4/3)x+32.5  What is the slope?", a = "4/3"},
	{q = "What programming language am I written in?", a = "lua"},
	{q = "Am I a bot or a person?", a = "bot"},
	{q = "Get to the chopper! - Arnold ?", a = "schwarzenegger"},
	{q = "What is the AD scaling of Riven's, The Exile, w ability?", a = "1"},
	{q = "Which company owns League of Legends?", a = "Riot Games"},
	{q = "Who owns the rights to Dota 2?", a = "Valve"},
	{q = "What month is it if today is 10/10/13?", a = "October"},
	{q = "If today is tuesday, what is yesterday's next week?", a = "Monday"},
	{q = "What's the name of Barbie Doll's boyfriend?", a = "Ken"},
	{q = "The Bermuda Triangle is located in what ocean?", a = "Atlantic"},
	{q = "In which state is the Grand Canyon located in?", a = "Arizona"},
	{q = "What was banned in the US under the terms of the 18th Amendment?", a = "Alcohol"},
	{q = "Is it true that the female penguin does not incubate her eggs?", a = "Yes"},
	{q = "Who was said to float like a butterfly and sting like a bee?", a = "Muhammad"},
	{q = "The Himalayas are located on which continent?", a = "Asia"},
	{q = "In what European city was Jack the Ripper active?", a = "London"},
	{q = "What year was the first iPad released?", a = "2010"},
	{q = "Where is the Abominable Snowman said to wander?", a = "Himalayas"},
	{q = "Which game series features a demon-slaying character named Dante?", a = "Devil May Cry"},
	{q = "What iPod was the first without a screen or a scroll wheel?", a = "Ipod Shuffle"},
	{q = "Which year was the first Indiana Jones movie released?", a = "1981"},
	{q = "Which is US's largest state by land area?", a = "Alaska"},
	{q = "How many bends does a standard paperclip have?", a = "3"},
	{q = "How would you write 99 in Roman numerals?", a = "XCIX"},
	{q = "What metal is also known as quicksilver?", a = "Mercury"},
	{q = "In what arcade game did the player attempt to avoid vehicle traffic and crocodiles?", a = "Frogger"},
	{q = "Which is the only one of the Seven Dwarfs without a beard?", a = "Dopey"},
	{q = "Who holds more market share of browers, Opera or Chrome?", a = "Chrome"},
	{q = "Who owns the rights to Dota 2?", a = "Valve"},
	{q = "Which character's trademark weapon is a crowbar?", a = "Gordon Freeman"},
	{q = "Name the king who failed to keep an eye on things at the battle of Hastings", a = "Harold"},
	{q = "In which sport would you use a chucker?", a = "Polo"},
	{q = "If a snail climbed up a 12 ft wall at a steady rate of 3 feet a day, but slipped down 2ft every night, how many days would it take him to reach the top?", a = "10 days"},
	{q = "Traditionally, what type of wood do Rolls Royce use on the dashboards of their cars?", a = "Walnut"},
	{q = "What is the national emblem of Canada?", a = "Maple leaf"},
	{q = "Are Gorillas carnivores, omnivores, or herbivores?", a = "Herbivores"},
	{q = "Free Willey was a film about what?", a = "A whale"},
	{q = "In the song `The 12 days of Christmas`, what are the 6 geese a-doing", a = "Laying"},
	{q = "What is the square route of 250,000", a = "500"},
	{q = "What is the most abundant metal on Earth?", a = "Iron"},
	{q = "What is the capital of Sweden?", a = "Stockholm"},
	{q = "What is Tiger Woods' real first name?", a = "Eldrick"},
	{q = "How is the year 2000 written in Roman numerals?", a = "MM"},
	{q = "What element has the atomic number 26?", a = "Iron"},
	{q = "The first consumer products made from plastics were what?", a = "Hair combs"},
	{q = "How many wings does a butterfly have?", a = "Four"},
	{q = "How many chromosomes does a cow have?", a = "60"},
	{q = "Which country is home to the Great Barrier Reef?", a = "Australia"},
	{q = "Who sent the Spanish Armada to invade England?", a = "Philip II"},
	{q = "In which US state would you find the zip code 12345?", a = "New York"},
	{q = "What is the term for the visible surface of the Sun?", a = "Photosphere"},
	{q = "What year was Ben Franklin born in?", a = "1706"},
	{q = "What is the two letter postal abbreviation for the state of Maine?", a = "ME"},
	{q = "In ancient times, what material where the first musical instruments made of?", a = "Bones"},
	{q = "In The Simpsons, what was Martin's soap box racer named?", a = "The Honor Roller"},
	{q = "What was the first railroad to cross the US?", a = "The Union Pacific"},
	{q = "What is a dromophobiac afraid to cross?", a = "A street"},
	{q = "When was the game Scrabble first released?", a = "1948"},
	{q = "What was the original Dutch name of New York City?", a = "New Amsterdam"},
	{q = "How many toes on each foot does an ostrich stand on?", a = "Two"},
	{q = "Who directed the 2003 movie Monster?", a = "Patty Jenkins"},
	{q = "How many letters are in the Hawaiian alphabet?", a = "Twelve"},
	{q = "Where is Pennsylvania Station?", a = "New York City"},
	{q = "Who was the first union president to occupy the Oval Office?", a = "Ronal Reagan"},
	{q = "Whose image is on the Canadian $10 bill?", a = "Sir John A. Macdonald"},
	{q = "Thursday Island is located in the Torres Strait off the coast of what country?", a = "Australia"},
	{q = "What 2000 movie depicts the war on drugs in Ohio, California and Mexico?", a = "Traffic"},
	{q = "What US president was known as Father of the Constitution?", a = "James Madison"},
	{q = "What name is given to an elephant's second incisors?", a = "Tusks"},
	{q = "Bill Cosby is a famous alumnus of what Philadelphia university?", a = "Temple University"},
	{q = "How many lords are leaping in the song The Twelve Days of Christmas?", a = "Ten"},
	{q = "What is the capital of Portugal?", a = "Lisbon"},
	{q = "Who does Emma Watson play in the Harry Potter films?", a = "Hermione"},
	{q = "What country offered Albert Einstein its presidency in 1952?", a = "Israel"},
	{q = "Do ants sleep?", a = "No"},
	{q = "What company did Frederick W. Smith found in 1972 in Memphis?", a = "Federal Express"},
	{q = "Where is the Parthenon located?", a = "Greece"},
	{q = "What is the largest planet in the solar system?", a = "Jupiter"},
	{q = "Apple's CEO Steve Jobs was known for wearing what color turtleneck?", a = "Black"},
	{q = "Thor is the son of which Norse god?", a = "Odin"},
	{q = "What is the capital of Egypt?", a = "Cairo"},
	{q = "Which was the first city to be devastated by the dropping of an atomic bomb?", a = "Hiroshima"},
	{q = "How many pairs of hearts does the common garden worm have?", a = "5"},
	{q = "What is the northernmost Scandinavian country?", a = "Norway"},
	{q = "What is the capital of Estonia?", a = "Tallinn"},
	{q = "The Sphinx is a statue that guards what?", a = "Pyramids of Giza"},
	{q = "How many claws does a housecat have?", a = "Eighteen"},
	{q = "What company was the first to sell prepared baby food in glass jars?", a = "Beech-Nut"},
	{q = "How many territories are there in Canada?", a = "3"},
	{q = "Which US state was an independent nation for ten years during the 19th century?", a = "Texas"},
	{q = "In terms of area, how much bigger is Queensland than the UK?", a = "Seven times"},
	{q = "What decade saw the first US postage stamp issued?", a = "1840s"},
	{q = "What is the point value of the letter K in Scrabble?", a = "Five"},
	{q = "What letter is most used in the English language?", a = "E"},
	{q = "Which is colder, the North or South Pole?", a = "The South Pole"},
	{q = "In what movie does Elvis Presley play race car driver Lucky Jackson?", a = "Viva Las Vegas"},
	{q = "In land area, what is the largest country in South America?", a = "Brazil"},
	{q = "What is the name of Google's mobile operating system?", a = "Android"},
	{q = "What is gymnophobia the fear of?", a = "Nudity"},
	{q = "What musical instrument does Sherlock Holmes play for relaxation?", a = "Violin"},
	{q = "What is New York City's most popular nickname?", a = "The Big Apple"},
	
}

local qtab = {}
local Question = {}

//Message function
local function MsgDis(tbl)
	timer.Simple(0.1, function()
	net.Start("ChatBot")
	net.WriteTable(tbl)
	if (SpectatorOnly) then
		for k,v in pairs(player.GetAll()) do
			if !(v:Alive()) then
				net.Send(v)
			end
	end
		else
			net.Broadcast()
		end
	end)
end

local function AskQ()
	qtab = table.Random(QaA)
	ques = qtab.q
	ans = qtab.a
	ans = string.lower(ans)
	Question = { red, "[", blue, botname, red, "]", white, " Question: ", ques}
	MsgDis(Question)
end

hook.Add( "PlayerSay", "Trivia-ChatBot", function( ply, message, isteam)
	
	// start the game
	if ((message) == "trivstart") && ply:IsAdmin() &&  (trivia == false) then
		trivia = true
		auto = false
		MsgDis(StartMessage)
	end
	
	// end the game
	if (ply:IsAdmin()) && (message == "trivend") && (trivia == true) then
		trivia = false
		QP = false
		auto = false
		for k, ply in pairs(player.GetAll()) do
			ply.tp = 0
		end
		MsgDis(EndMessage)
	end
	
	// ask a question
	if ply:IsAdmin() && message == "q" && trivia == true && QP == false then
		AskQ()
		QP = true
	end
	
	// if one is in progress
	if ply:IsAdmin() && message == "trivq" && trivia == true && QP == true then
		MsgDis(QInProgress)
	end
	
	// whats the answer?
	if ply:IsAdmin() && message == "a" && trivia == true && QP == true then
		QP = false
		AnswerG = { red, "[", blue, botname, red, "]", white, " The answer was ", ans, "."}
		MsgDis(AnswerG)
	end
	
	// how many points?
	if message == "points" && trivia == true then
		if !(ply.tp) then
			ply.tp = 0
		end
		PPoints = {red, "[", blue, botname, red, "]", white, " Player ", ply:GetName(), " has ", tostring(ply.tp), " points!"}
		MsgDis(PPoints)
	end
	
	// HURR
	if message == "fuck you trivia bot" && trivia == true then
		if !(ply.tp) then
			ply.tp = 0
		end
		lol = {red, "[", blue, botname, red, "]", white, " I am going to fucking murder ", ply:GetName(), "."}
		MsgDis(lol)
	end
	
		// HURR
	if message == "sorry :c" && trivia == true then
		if !(ply.tp) then
			ply.tp = 0
		end
		lols = {red, "[", blue, botname, red, "]", white, " :)"}
		MsgDis(lols)
	end
	
	//faq
	if string.lower(message) == "trivfaq" && trivia == true then
		MsgDis(Faq)
	end
	
	// ? again
	if message == "again" && trivia == true && QP == true then
		MsgDis(Question)
	end
	
	// no pregunta
	if message == "again" && trivia == true && QP == false then
		MsgDis(Empty)
	end
	
	// auto mode
	if ply:IsAdmin() && message == "auto" && trivia == true then
		auto = true
		MsgDis(AutoOn)
	end
	 
	// automode off
	if ply:IsAdmin() && message == "autooff" && trivia == true then
		auto = false
		MsgDis(autoOff)
	end
	
	// answer the trivia
	if (ans == message) or (ans == string.lower(message)) && (trivia == true) && (QP == true) then
		
		if (SpectatorOnly) && ply:Alive() then return end
	
		if !(ply.tp) then
			ply.tp = 0
		end
		
		ply.tp = ply.tp + 1
		winner = ply
		
		if (winner ~= nil) then
			QP = false
			winner = nil
			if (GivePSPoints) then
				ply:PS_GivePoints(PSPointsAmount)
			end
			Answered = {red, "[", blue, botname, red, "]", white, ply:GetName() .. " was correct first! Now ".. ply.tp .." points!"}
			MsgDis(Answered)
		end
	end
	
end)

//auto timer
timer.Create("AutoTriv", QuestionInterval, 0, function()
	if auto == true && QP == false && trivia == true then
		QP = true
		AskQ()
	end
end)
