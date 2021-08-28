Seatbelt = {}

// Seatbelt settings
Seatbelt.cooldown = 2 -- How long should the strap in cooldown be? (Don't go lower than 2 or else it will cause bugs!)

Seatbelt.volume = 1 -- How loud should the strap in sound be? (Max 0 - 1)

Seatbelt.range = 5 -- How far should you hear it? (Max 0 - 150)

Seatbelt.key = KEY_G -- What Key do you need to press in order to strap in?


// Chime settings
Seatbelt.chimevolume = 1 -- How loud should the chime volume be? (Max 0 - 1, set it to 0 to disable the chime)

Seatbelt.chimemph = 30 -- If you are faster than this value in mph the chime turns on

Seatbelt.checkspeed = 1 -- If you have a big server increase this to get better performance (Time it takes to check your speed so in the default case every second)


// Seatbelt logo settings
Seatbelt.logo = "materials/logo/seatbelt_red.png"
-- What Seatbelt warning logo color do you want to use? You can choose between:
-- seatbelt_black.png | seatbelt_gray.png | seatbelt_red.png

Seatbelt.strapin = 0.8 -- How fast should the strap in logo animation be?

Seatbelt.unstrap = 2 -- How fast should the unstrap logo animation be?