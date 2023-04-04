X, Y = 0, 0

PREV_PRESSED = ''
CURRENT_COMBINATION = "nomove"
UPDATE = false

math.randomseed(os.time()) -- generate random number based on current time

function love.load()
    pos_x_knight = 4
    pos_y_knight = 4
    pos_x_pawn = 3
    pos_y_pawn = 2

    score = 0

    white = {1, 1, 1}
    black = {0, 0, 0}

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
    love.graphics.draw(image_knight, pos_x_knight*100, pos_y_knight*100 + 100)
    love.graphics.draw(image_pawn, pos_x_pawn*100, pos_y_pawn*100 + 100)
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