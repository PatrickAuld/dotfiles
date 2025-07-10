hs.loadSpoon("anycomplete")
spoon.anycomplete:bindHotkeys({
    search = { {"cmd", "alt", "ctrl"}, "G" }
})

hs.loadSpoon("emojicomplete")
spoon.emojicomplete:bindHotkeys({
    search = { {"cmd", "alt", "ctrl"}, "E" }
})

hs.loadSpoon("LockScreen")
spoon.LockScreen:bindHotkeys({
    lock = { {"cmd", "alt", "ctrl"}, "L" },
    sleep = { {"cmd", "alt", "ctrl"}, "S" }
})

