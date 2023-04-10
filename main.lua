require("game/util")

function love.load()
    init()
    load_image()
    reset_game()
    
    game_screen = require("game/game")
    start_screen = require("game/start")
    
    current = start_screen

    current.load()
end

function love.update(dt)
    if isGameStarted == false then
        current = start_screen
    else
        current = game_screen
    end
    current.update(dt)
end

function love.draw()
    current.draw()
end

function love.keypressed(key)
    if current == game_screen then
        current.keypressed(key)
    end
end

function love.mousepressed(x, y, button)
    if current == start_screen then
        current.mousepressed(x, y, button)
    end
end

function switch_screen(next_screen)
    current = next_screen
end
