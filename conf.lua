WINDOW_WIDTH = 800
WINDOW_HEIGHT = WINDOW_WIDTH + 100

function love.conf(t)
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.title = "My Love Game"
    t.window.resizable = false
    t.console = false
end