-- keys should be "friendly" names
-- values must be valid scancodes
local keyBind = {
   a ="x", b="z",
   l="a", r="s",
   st="enter", sel="shift",
   du="i", dd="k",
   dl="j", dr="l"
}

-- populate an array of buttons
local buttons = {}
for k,v in pairs(keyBind) do buttons[k] = 0 end

input = {
   -- update should be called in main loop 60 times a second
   -- before functions that would grab that input
   update = function ()
      for k,v in pairs(keyBind) do
	 if love.keyboard.isScanCodeDown(buttons[v]) then
	    -- increment length of press for each frame pressed
	    buttons[k] = buttons[k]+1
	 else
	    -- reset to 0 when released
	    buttons[k] = 0
	 end
      end
   end,
}

-- Bind "input.a", for example, to the value of a
-- but return it; do not allow modification
input.mt = {
   __index = function (table, key)
      return buttons[key]
   end
   
}

setmetatable(input, input.mt)

return input
