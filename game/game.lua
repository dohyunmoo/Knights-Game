require("game/util")
local game_screen = {}

DIRECTIONS = {
    ["upleft"] = { x = -1, y = -2 },
    ["upright"] = { x = 1, y = -2 },
    ["leftup"] = { x = -2, y = -1 },
    ["leftdown"] = { x = -2, y = 1 },
    ["downleft"] = { x = -1, y = 2 },
    ["downright"] = { x = 1, y = 2 },
    ["rightup"] = { x = 2, y = -1 },
    ["rightdown"] = { x = 2, y = 1 },
    ["nomove"] = { x = 0, y = 0 }
}

function game_screen.load()
    load_image()
    reset_game()

    font = love.graphics.newFont(24)

    white = {1, 1, 1}
    black = {0, 0, 0}
    brown = {0.6, 0.4, 0.2}
    yellow = {1, 1, 0}

    -- set the background color
    love.graphics.setBackgroundColor(white)
  
    -- set the text color
    love.graphics.setColor(black)
end

function game_screen.update(dt)
    if UPDATE then
        local x_val = pos_x_knight + X
        local y_val = pos_y_knight + Y
        if x_val >= 0 and x_val <= WINDOW_WIDTH / BLOCK_WIDTH - 1 and y_val >= 1 and y_val <= WINDOW_WIDTH / BLOCK_WIDTH then
            pos_x_knight = x_val
            pos_y_knight = y_val

            if pos_x_knight == pos_x_enemy and pos_y_knight == pos_y_enemy then
                captured() -- captured actions
            end
        else
            shake() -- if move cannot be made, the knight shakes
        end
    end

    if shake_time > 0 then
        shake_time = shake_time - dt
        shake_x = love.math.random(-5, 5)
    else
        shake_x = 0
    end

    if time_left > 0 then
        time_left = time_left - dt
    else
        isGameStarted = false
        reset_screen()
        reset_game()
    end

    UPDATE = false
end

function game_screen.draw()
    love.graphics.clear()
    love.graphics.setFont(font)
    
    for i = 0, block_count - 1 do
        for j = 0, block_count - 1 do
            if (i + j) % 2 == 0 then
                love.graphics.setColor(white)
            else
                love.graphics.setColor(black)
            end
            love.graphics.rectangle("fill", i * BLOCK_WIDTH, j * BLOCK_WIDTH + BLOCK_WIDTH, BLOCK_WIDTH, BLOCK_WIDTH)
        end
    end

    love.graphics.setColor(white)
    love.graphics.printf("Score: " .. tostring(score), WINDOW_WIDTH / 4, BLOCK_WIDTH / 8, WINDOW_WIDTH/2, "center")

    love.graphics.setColor(yellow)
    love.graphics.rectangle("fill", 0, BLOCK_WIDTH / 2, WINDOW_WIDTH * (time_left / MAX_TIME_CURRENT_ROUND), BLOCK_WIDTH / 2)

    love.graphics.push()
    love.graphics.translate(shake_x, 0)
    love.graphics.setColor(white)
    love.graphics.draw(image_knight, pos_x_knight * BLOCK_WIDTH, pos_y_knight * BLOCK_WIDTH, 0, BLOCK_WIDTH / BASE_BLOCK_WIDTH, BLOCK_WIDTH / BASE_BLOCK_WIDTH)
    love.graphics.pop()
    
    love.graphics.setColor(white)
    love.graphics.draw(enemy, pos_x_enemy * BLOCK_WIDTH, pos_y_enemy * BLOCK_WIDTH, 0, BLOCK_WIDTH / BASE_BLOCK_WIDTH, BLOCK_WIDTH / BASE_BLOCK_WIDTH)
end

function game_screen.keypressed(key)
    if PREV_PRESSED == '' then
        PREV_PRESSED = key
    else
        if PREV_PRESSED == "up" and love.keyboard.isDown("left") then
            CURRENT_COMBINATION = "upleft"
        elseif PREV_PRESSED == "up" and love.keyboard.isDown("right") then
            CURRENT_COMBINATION = "upright"
        elseif PREV_PRESSED == "left" and love.keyboard.isDown("up") then
            CURRENT_COMBINATION = "leftup"
        elseif PREV_PRESSED == "left" and love.keyboard.isDown("down") then
            CURRENT_COMBINATION = "leftdown"
        elseif PREV_PRESSED == "down" and love.keyboard.isDown("right") then
            CURRENT_COMBINATION = "downright"
        elseif PREV_PRESSED == "down" and love.keyboard.isDown("left") then
            CURRENT_COMBINATION = "downleft"
        elseif PREV_PRESSED == "right" and love.keyboard.isDown("up") then
            CURRENT_COMBINATION = "rightup"
        elseif PREV_PRESSED == "right" and love.keyboard.isDown("down") then
            CURRENT_COMBINATION = "rightdown"
        else
            CURRENT_COMBINATION = "nomove"
            shake()
        end
        PREV_PRESSED = ''
        UPDATE = true
    end

    X, Y = DIRECTIONS[CURRENT_COMBINATION].x, DIRECTIONS[CURRENT_COMBINATION].y
end

return game_screen
