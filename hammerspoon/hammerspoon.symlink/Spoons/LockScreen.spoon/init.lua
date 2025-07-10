local obj = {}
obj.__index = obj

-- Metadata
obj.name = "LockScreen"
obj.version = "1.0"
obj.author = "Patrick Marsceill"
obj.license = "MIT"

-- Lock the screen
function obj:lockScreen()
    hs.caffeinate.lockScreen()
    hs.alert.show("Screen locked")
end

-- Put display to sleep
function obj:turnOffDisplay()
    hs.caffeinate.systemSleep()
    hs.alert.show("Display sleeping")
end

-- Binding function
function obj:bindHotkeys(mapping)
    local def = {
        lock = hs.fnutils.partial(self.lockScreen, self),
        sleep = hs.fnutils.partial(self.turnOffDisplay, self)
    }
    hs.spoons.bindHotkeysToSpec(def, mapping)
end

return obj