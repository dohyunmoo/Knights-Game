WINDOW_WIDTH = 800
WINDOW_HEIGHT = 900

function love.conf(t)
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.title = "My Love Game"
    t.window.resizable = false
end