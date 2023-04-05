X, Y = 0, 0

PREV_PRESSED = ''
CURRENT_COMBINATION = "nomove"
UPDATE = false
SHAKE = false

BLOCK_WIDTH = 100 -- in pixels

local shake_time = 0
local shake_x = 0

math.randomseed(os.time()) -- generate random number based on current time

function love.load()
    -- initial spawn coordinates
    pos_x_knight = 4
    pos_y_knight = 4
    pos_x_pawn = 3
    pos_y_pawn = 2

    font = love.graphics.newFont(24)

    score = 0

    white = {1, 1, 1}
    black = {0, 0, 0}
    brown = {0.6, 0.4, 0.2}
    yellow = {1, 1, 0}

    image_knight = love.graphics.newImage("assets/knight.png")
    image_pawn = love.graphics.newImage("assets/pawn.png")
end

function love.update(dt)
    if UPDATE then
        local x_val = pos_x_knight + X
        local y_val = pos_y_knight + Y
        if x_val >= 0 and x_val <= 7 and y_val >= 0 and y_val <= 7 then
            pos_x_knight = x_val
            pos_y_knight = y_val

            if pos_x_knight == pos_x_pawn and pos_y_knight == pos_y_pawn then
                score = score + 1
                pos_x_pawn = math.random(0, 7)
                pos_y_pawn = math.random(0, 7)
                while pos_x_pawn == pos_x_knight and pos_y_pawn == pos_y_knight do
                    pos_x_pawn = math.random(0, 7)
                    pos_y_pawn = math.random(0, 7)
                end
            end
        end
    end

    if shake_time > 0 then
        shake_time = shake_time - dt
        shake_x = love.math.random(-5, 5)
    else
        shake_x = 0
    end

    UPDATE = false
end

function love.draw()
    love.graphics.setFont(font)

    local window_width = love.graphics.getWidth()

    for i = 0, 7 do
        for j = 0, 7 do
            if (i + j) % 2 == 0 then
                love.graphics.setColor(white)
            else
                love.graphics.setColor(black)
            end
            love.graphics.rectangle("fill", i * BLOCK_WIDTH, j * BLOCK_WIDTH + BLOCK_WIDTH, BLOCK_WIDTH, BLOCK_WIDTH)
        end
    end

    love.graphics.setColor(white)
    love.graphics.printf("Score: " .. tostring(score), window_width/4, BLOCK_WIDTH/8, window_width/2, "center")

    love.graphics.setColor(yellow)
    love.graphics.rectangle("fill", 0, BLOCK_WIDTH/2, window_width, BLOCK_WIDTH/2)

    -- love.graphics.push()
    -- love.graphics.translate(shake_x, 0)
    love.graphics.setColor(white)
    love.graphics.draw(image_knight, pos_x_knight*BLOCK_WIDTH, pos_y_knight*BLOCK_WIDTH + BLOCK_WIDTH)
    
    -- love.graphics.pop()
    
    love.graphics.draw(image_pawn, pos_x_pawn*BLOCK_WIDTH, pos_y_pawn*BLOCK_WIDTH + BLOCK_WIDTH)
end

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

function love.keypressed(key)

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
            shake_time = 0.5
        end
        PREV_PRESSED = ''
        UPDATE = true
    end

    X, Y = DIRECTIONS[CURRENT_COMBINATION].x, DIRECTIONS[CURRENT_COMBINATION].y
end
