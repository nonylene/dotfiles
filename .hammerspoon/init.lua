units = {
  right50 = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50  = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50   = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50   = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}
mash = { 'ctrl', 'cmd' }

hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50, nil, true, 0) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50, nil, true, 0) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top50, nil, true, 0) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot50, nil, true, 0) end)
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.maximum, nil, true, 0) end)
hs.hotkey.bind(mash, 'n', function() hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next(), false, true, 0) end)
