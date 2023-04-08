require("conf")

local game_screen = require("game/game")
local start_screen = require("game/start")

local current = game_screen

function love.load()
    current.load()
end

function love.update(dt)
    current.update(dt)
end

function love.draw()
    current.draw()
end

function love.keypressed(key)
    current.keypressed(key)
end

function love.mousepressed(x, y, button)
    current.mousepressed(x, y, button)
end

function love.handlers.switchScreen(nextScreenName)
    current = _G[nextScreenName]
    current.load()
  end
