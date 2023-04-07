require("game/util")
require("conf")

X, Y = 0, 0

PREV_PRESSED = ''
CURRENT_COMBINATION = "nomove"
UPDATE = false
SHAKE = false

BLOCK_WIDTH = 100 -- in pixels

local easy_button = {
    x = WINDOW_WIDTH/4,
    y = WINDOW_HEIGHT/4,
    w = WINDOW_WIDTH/2,
    h = WINDOW_HEIGHT/2
}

local medium_button = {
    x = WINDOW_WIDTH/4,
    y = WINDOW_HEIGHT/4,
    w = WINDOW_WIDTH/2,
    h = WINDOW_HEIGHT/2
}

local isGameStarted = false

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

function love.load()
    reset_game()
    
    font = love.graphics.newFont(24)

    white = {1, 1, 1}
    black = {0, 0, 0}
    brown = {0.6, 0.4, 0.2}
    yellow = {1, 1, 0}

    love.graphics.setBackgroundColor(black)

    image_knight = love.graphics.newImage("assets/knight.png")
    image_pawn = love.graphics.newImage("assets/pawn.png")
    -- set the background color
    love.graphics.setBackgroundColor(255, 255, 255)
  
    -- load the font
    font = love.graphics.newFont(24)
  
    -- set the text color
    love.graphics.setColor(black)
  
    -- load the image
    image2 = love.graphics.newImage("assets/man.png")
end

function love.update(dt)
    if UPDATE then
        local x_val = pos_x_knight + X
        local y_val = pos_y_knight + Y
        if x_val >= 0 and x_val <= WINDOW_WIDTH / BLOCK_WIDTH and y_val >= 0 and y_val <= WINDOW_HEIGHT / BLOCK_WIDTH then
            pos_x_knight = x_val
            pos_y_knight = y_val

            if pos_x_knight == pos_x_pawn and pos_y_knight == pos_y_pawn then
                score = score + 1
                pos_x_pawn = math.random(0, WINDOW_WIDTH / BLOCK_WIDTH)
                pos_y_pawn = math.random(0, WINDOW_HEIGHT / BLOCK_WIDTH)
                reset_timer()
                while pos_x_pawn == pos_x_knight and pos_y_pawn == pos_y_knight do
                    pos_x_pawn = math.random(0, WINDOW_WIDTH / BLOCK_WIDTH)
                    pos_y_pawn = math.random(0, WINDOW_HEIGHT / BLOCK_WIDTH)
                end
            end
        else
            -- if move cannot be made, the knight shakes
            shake()
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
        reset_game()
    end

    UPDATE = false
end

function love.mousepressed(x, y, button)
    if not isGameStarted then
        if button == 1 and x >= startButton.x and x <= startButton.x + startButton.w and y >= startButton.y and y <= startButton.y + startButton.h then
            isGameStarted = true
            time_left = MAX_TIME_CURRENT_ROUND
        end
    end
  end

function love.draw()
    if not isGameStarted then
        love.graphics.rectangle("line", startButton.x, startButton.y, startButton.w, startButton.h)
        love.graphics.print("Start", startButton.x + startButton.w / 2 - 20, startButton.y + startButton.h / 2 - 10)
        love.graphics.print("Welcome to My Game", 100, 100)
    else
        love.graphics.clear()
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
        love.graphics.rectangle("fill", 0, BLOCK_WIDTH/2, window_width * (time_left / MAX_TIME_CURRENT_ROUND), BLOCK_WIDTH/2)
    
        love.graphics.push()
        love.graphics.translate(shake_x, 0)
        love.graphics.setColor(white)
        love.graphics.draw(image_knight, pos_x_knight * BLOCK_WIDTH, pos_y_knight * BLOCK_WIDTH + BLOCK_WIDTH)
        love.graphics.pop()
        
        love.graphics.setColor(white)
        love.graphics.draw(image_pawn, pos_x_pawn * BLOCK_WIDTH, pos_y_pawn * BLOCK_WIDTH + BLOCK_WIDTH)
    end
end

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
            shake()
        end
        PREV_PRESSED = ''
        UPDATE = true
    end

    X, Y = DIRECTIONS[CURRENT_COMBINATION].x, DIRECTIONS[CURRENT_COMBINATION].y
end
