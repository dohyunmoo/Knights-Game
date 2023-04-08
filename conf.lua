BASE_WINDOW_WIDTH = 800
BASE_WINDOW_HEIGHT = BASE_WINDOW_WIDTH + 100

function love.conf(t)
    t.window.width = BASE_WINDOW_WIDTH
    t.window.height = BASE_WINDOW_HEIGHT
    t.window.title = "Knight's Game"
    t.window.resizable = false
end
