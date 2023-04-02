X, Y = 0, 0

function love.draw()
    love.graphics.print(tostring(X), 300, 300)
    love.graphics.print(tostring(Y), 500, 300)
end

local directions = {
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
    local current_combination = "nomove"
    
    -- check which keys are currently pressed
    if love.keyboard.isDown("w") then
        if love.keyboard.isDown("a") then
            current_combination = "upleft"
        elseif love.keyboard.isDown("d") then
            current_combination = "upright"
        end
    end
    if love.keyboard.isDown("a") then
        if love.keyboard.isDown("w") then
            current_combination = "leftup"
        elseif love.keyboard.isDown("s") then
            current_combination = "leftdown"
        end
    end
    if love.keyboard.isDown("s") then
        if love.keyboard.isDown("a") then
            current_combination = "downleft"
        elseif love.keyboard.isDown("d") then
            current_combination = "downright"
        end
    end
    if love.keyboard.isDown("d") then
        if love.keyboard.isDown("w") then
            current_combination = "rightup"
        elseif love.keyboard.isDown("s") then
            current_combination = "rightdown"
        end
    end

    X, Y = directions[current_combination].x, directions[current_combination].y
end