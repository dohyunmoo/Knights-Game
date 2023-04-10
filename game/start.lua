require("game/util")
local start_screen = {}

local tenth = WINDOW_WIDTH/10

local easy_button = {
    x = tenth,
    y = WINDOW_HEIGHT/2 - 1.5*tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

local medium_button = {
    x = 4 * tenth,
    y = WINDOW_HEIGHT/2 - 1.5*tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

local hard_button = {
    x = 7 * tenth,
    y = WINDOW_HEIGHT/2 - 1.5*tenth,
    w = 2 * tenth,
    h = 2 * tenth
}

local info_button = {
    x = WINDOW_WIDTH - tenth,
    y = tenth/2,
    r = tenth/4
}

function start_screen.load()
    font = love.graphics.newFont("assets/NotoMono.ttf", 24)
    title_font = love.graphics.newFont("assets/NotoMono.ttf", 76)
    info_font = love.graphics.newFont(tenth/4)
    info_message_font = love.graphics.newFont(tenth/5)
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
    
    love.graphics.setColor(black)
    love.graphics.printf("High Scores", 0, WINDOW_HEIGHT/2 + tenth, WINDOW_WIDTH, "center")
    
    love.graphics.printf(tostring(highscore_easy), easy_button.x, WINDOW_HEIGHT/2 + 2*tenth, easy_button.w, "center")
    love.graphics.printf(tostring(highscore_medium), medium_button.x, WINDOW_HEIGHT/2 + 2*tenth, medium_button.w, "center")
    love.graphics.printf(tostring(highscore_hard), hard_button.x, WINDOW_HEIGHT/2 + 2*tenth, hard_button.w, "center")
    
    love.graphics.setColor(blue)
    love.graphics.circle("fill", info_button.x + info_button.r, info_button.y + info_button.r, info_button.r)
    love.graphics.setFont(info_font)
    love.graphics.setColor(white)
    love.graphics.printf('i', info_button.x + info_button.r/2, info_button.y + info_button.r/2, info_button.r, "center")
end

function start_screen.mousepressed(x, y, button)
    if isGameStarted == false then
        if button == 1 and x >= info_button.x - info_button.r and x <= info_button.x + info_button.r and y >= info_button.y - info_button.r and y <= info_button.y + info_button.r then
            isInfo = true
        elseif button == 1 and x >= easy_button.x and x <= easy_button.x + easy_button.w and y >= easy_button.y and y <= easy_button.y + easy_button.h then
            mode_change("easy")
        elseif button == 1 and x >= medium_button.x and x <= medium_button.x + medium_button.w and y >= medium_button.y and y <= medium_button.y + medium_button.h then
            mode_change("medium")
        elseif button == 1 and x >= hard_button.x and x <= hard_button.x + hard_button.w and y >= hard_button.y and y <= hard_button.y + hard_button.h then
            mode_change("hard")
        end
    end
end

return start_screen
