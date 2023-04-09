require("game/util")
local start_screen = {}

local tenth = WINDOW_WIDTH/10

local easy_button = {
    x = tenth,
    y = WINDOW_HEIGHT/2 - tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

local medium_button = {
    x = 4 * tenth,
    y = WINDOW_HEIGHT/2 - tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

local hard_button = {
    x = 7 * tenth,
    y = WINDOW_HEIGHT/2 - tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

function start_screen.load()
    font = love.graphics.newFont(24)
    title_font = love.graphics.newFont(76)
end

function start_screen.update(dt)
    
end

function start_screen.draw()
    love.graphics.setBackgroundColor(white)

    love.graphics.setFont(title_font)
    love.graphics.setColor(black)
    love.graphics.printf("Knight's Game", 0, 2*tenth, WINDOW_WIDTH, "center")
    
    love.graphics.setFont(font)
    love.graphics.rectangle("fill", easy_button.x, easy_button.y, easy_button.w, easy_button.h)
    love.graphics.rectangle("fill", medium_button.x, medium_button.y, medium_button.w, medium_button.h)
    love.graphics.rectangle("fill", hard_button.x, hard_button.y, hard_button.w, hard_button.h)

    love.graphics.setColor(white)
    love.graphics.printf("5x5", easy_button.x, easy_button.y + (easy_button.h/2 - font_size/2), easy_button.w, "center")
    love.graphics.printf("8x8", medium_button.x, medium_button.y + (medium_button.h/2 - font_size/2), medium_button.w, "center")
    love.graphics.printf("12x12", hard_button.x, hard_button.y + (hard_button.h/2 - font_size/2), hard_button.w, "center")
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
