X, Y = 0, 0

PREV_PRESSED = ''
CURRENT_COMBINATION = "nomove"
UPDATE = false

function love.load()
    pos_x = 4
    pos_y = 4

    white = {1, 1, 1}
    black = {0, 0, 0}

    image = love.graphics.newImage("assets/knight.png")
end

function love.update(dt)
    if UPDATE then
        local x_val = pos_x + X
        local y_val = pos_y + Y
        if x_val >= 0 and x_val <= 7 and y_val >= 0 and y_val <= 7 then
            pos_x = x_val
            pos_y = y_val
        end
    end
    UPDATE = false
end

function love.draw()
    for i = 0, 7 do
        for j = 0, 7 do
            if (i + j) % 2 == 0 then
                love.graphics.setColor(white)
            else
                love.graphics.setColor(black)
            end
            love.graphics.rectangle("fill", i * 100, j * 100 + 100, 100, 100)
        end
    end
    love.graphics.draw(image, pos_x*100, pos_y*100 + 100)
    -- love.graphics.draw(image, 0, 100)
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
        end
        PREV_PRESSED = ''
        UPDATE = true
    end

    X, Y = DIRECTIONS[CURRENT_COMBINATION].x, DIRECTIONS[CURRENT_COMBINATION].y
end