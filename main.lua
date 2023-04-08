require("game/util")

local game_screen = require("game/game")
local start_screen = require("game/start")

local current = start_screen

function love.load()
    load_image()
    reset_game()
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
