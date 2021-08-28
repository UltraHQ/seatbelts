## This addon is unfinished, uncleaned and bad coded. I did this addon back then to teach myself more LUA this way. I planned releasing it, but never did it because I quit gmod and have no interest in working on it anymore.


# Seatbelts - An addon that adds Seatbelts to cars.
You're maybe asking yourself, why do I need seatbelts in Garry's Mod?
Imagine you have a SeriousRP server running. To make the RP more serious you want to make it as realistic as possible, right?
That's why I created this. There are many addons available, but there is no addon adding seatbelts to the game (Or atleast at the time I'm writing).


## FEATURES:
* VCMod support
* (Only VCMod) Can't change seats while strapped
* Vehicle exiting blocked while strapped
* Nice logo animation
* Strap in sounds are hearable for other players
* Chime sounds if you do not wear your seatbelt
* 3 predone seatbelt logos in different colors
* Cooldown so players can't spam
* Chime sounds go on if you are faster than 30 mph (default value configurable)
* Materials are automatically downloaded for the player

#### Notice: This addon only works on a real Server, not a local server or singleplayer.


## Information
What exactly does this addon do?
You put your seatbelt on and you won't be able to:

1. Exit the vehicle and switch seats (vcmod).
2. The chime turns on if you have reached more than 25 mph (if left default) and you still don't have your seatbelt on.
3. Other players will hear the strap in sound from you.

## Config
```Seatbelt = {}

// Seatbelt settings
Seatbelt.cooldown = 2 -- How long should the strap in cooldown be? (Don't go lower than 2 or else it will cause bugs!)

Seatbelt.volume = 1 -- How loud should the strap in sound be? (Max 0 - 1)

Seatbelt.range = 5 -- How far should you hear it? (Max 0 - 150)

Seatbelt.key = KEY_G -- What Key do you need to press in order to strap in?


// Chime settings
Seatbelt.chimevolume = 1 -- How loud should the chime volume be? (Max 0 - 1, set it to 0 to disable the chime)

Seatbelt.chimemph = 25 -- If you are faster than this value in mph the chime turns on

Seatbelt.checkspeed = 1 -- If you have a big server increase this to get better performance (Time it takes to check your speed so in the default case every second)


// Seatbelt logo settings
Seatbelt.logo = "materials/logo/seatbelt_red.png"
-- What Seatbelt warning logo do you want to use? You can choose between:
-- seatbelt_black.png | seatbelt_gray.png | seatbelt_red.png

Seatbelt.strapin = 0.8 -- How fast should the strap in logo animation be?

Seatbelt.unstrap = 2 -- How fast should the unstrap logo animation be?```
