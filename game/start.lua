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

end

function start_screen.mousepressed(x, y, button)
    if not isGameStarted then
        if button == 1 and x >= easy_button.x and x <= easy_button.x + easy_button.w and y >= easy_button.y and y <= easy_button.y + easy_button.h then
            isGameStarted = true
            time_left = MAX_TIME_CURRENT_ROUND
        elseif button == 1 and x >= medium_button.x and x <= medium_button.x + medium_button.w and y >= medium_button.y and y <= medium_button.y + medium_button.h then
            isGameStarted = true
            time_left = MAX_TIME_CURRENT_ROUND
        elseif button == 1 and x >= hard_button.x and x <= hard_button.x + hard_button.w and y >= hard_button.y and y <= hard_button.y + hard_button.h then
            isGameStarted = true
            time_left = MAX_TIME_CURRENT_ROUND
        end
    end
end

return start_screen