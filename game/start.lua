require("game/util")
local start_screen = {}

BLOCK_WIDTH = 100 -- in pixels
local tenth = WINDOW_WIDTH/10

local easy_button = {
    x = tenth,
    y = WINDOW_HEIGHT/4,
    w = 2 * tenth,
    h = 2 * tenth
}

local medium_button = {
    x = 4 * tenth,
    y = WINDOW_HEIGHT/4,
    w = 2 * tenth,
    h = 2 * tenth
}

local hard_button = {
    x = 7 * tenth,
    y = WINDOW_HEIGHT/4,
    w = 2 * tenth,
    h = 2 * tenth
}

function start_screen.load()
    font = love.graphics.newFont(24)

    white = {1, 1, 1}
    black = {0, 0, 0}
    brown = {0.6, 0.4, 0.2}
    yellow = {1, 1, 0}
end

function start_screen.update(dt)
    
end

function start_screen.draw()
    love.graphics.setBackgroundColor(white)
    love.graphics.setColor(black)
    love.graphics.setFont(font)
    love.graphics.rectangle("line", easy_button.x, easy_button.y, easy_button.w, easy_button.h)
    love.graphics.rectangle("line", medium_button.x, medium_button.y, medium_button.w, medium_button.h)
    love.graphics.rectangle("line", hard_button.x, hard_button.y, hard_button.w, hard_button.h)
    love.graphics.print("easy mode", easy_button.x + easy_button.w / 2 - 20, easy_button.y + easy_button.h / 2 - 10)
    love.graphics.print("MEDIUM mode", medium_button.x + medium_button.w / 2 - 20, medium_button.y + medium_button.h / 2 - 10)
    love.graphics.print("HARD MODE", hard_button.x + hard_button.w / 2 - 20, hard_button.y + hard_button.h / 2 - 10)
end

function start_screen.mousepressed(x, y, button)
    if not isGameStarted then
        if button == 1 and x >= easy_button.x and x <= easy_button.x + easy_button.w and y >= easy_button.y and y <= easy_button.y + easy_button.h then
            mode_change("easy")
        elseif button == 1 and x >= medium_button.x and x <= medium_button.x + medium_button.w and y >= medium_button.y and y <= medium_button.y + medium_button.h then
            mode_change("medium")
        elseif button == 1 and x >= hard_button.x and x <= hard_button.x + hard_button.w and y >= hard_button.y and y <= hard_button.y + hard_button.h then
            mode_change("hard")
        end
        isGameStarted = true
        time_left = MAX_TIME_CURRENT_ROUND
        initial_spawn_pos()
    end
end

return start_screen
