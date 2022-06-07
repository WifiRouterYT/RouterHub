if(game.PlaceId == 189707) then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/WifiRouterYT/RouterHub/main/NDS.lua"))()
	print("Detected game - Natural Disaster Survival")
	print("Loading script.")
elseif(game.PlaceId == 2248408710) then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/WifiRouterYT/RouterHub/main/DS.lua"))()
	print("Detected game - Destruction Simulator")
	print("Loading script.")
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/WifiRouterYT/RouterHub/main/gamenotfound.lua"))()
	print("ERROR! Game script was not found or is not supported.")
	print("No script was loaded.")
end
