require("conf")

WINDOW_WIDTH = BASE_WINDOW_WIDTH
WINDOW_HEIGHT = BASE_WINDOW_HEIGHT
BASE_BLOCK_WIDTH = 100

font_size = 24

white = {1, 1, 1}
black = {0, 0, 0}
brown = {0.6, 0.4, 0.2}
yellow = {1, 1, 0}

function reset_timer()
    if score < 5 then
        MAX_TIME_CURRENT_ROUND = 10
    elseif score < 10 then
        MAX_TIME_CURRENT_ROUND = 7
    elseif score < 15 then
        MAX_TIME_CURRENT_ROUND = 5
    else
        MAX_TIME_CURRENT_ROUND = 3
    end
    time_left = MAX_TIME_CURRENT_ROUND
end

function reset_game()
    -- initial spawn coordinates
    pos_x_knight = 3
    pos_y_knight = 4
    pos_x_enemy = 4
    pos_y_enemy = 4
    MAX_TIME_CURRENT_ROUND = 10
    
    isGameStarted = false

    enemy = image_pawn

    score = 0
    time_left = MAX_TIME_CURRENT_ROUND

    shake_time = 0
    shake_x = 0

    X, Y = 0, 0

    PREV_PRESSED = ''
    CURRENT_COMBINATION = "nomove"
    UPDATE = false
    SHAKE = false

    mode = "medium"
    BLOCK_WIDTH = BASE_BLOCK_WIDTH
    block_count = WINDOW_WIDTH/BLOCK_WIDTH

    WINDOW_WIDTH = BASE_WINDOW_WIDTH
    WINDOW_HEIGHT = BASE_WINDOW_HEIGHT

    math.randomseed(os.time()) -- generate random number based on current time
end

function reset_screen()
    love.window.setMode(BASE_WINDOW_WIDTH, BASE_WINDOW_HEIGHT, {resizable=false}) -- return to base size
end

function shake() 
    shake_time = 0.2
end

function load_image()
    image_knight = love.graphics.newImage("assets/knight.png")
    
    image_pawn = love.graphics.newImage("assets/pawn.png")
    image_bknight = love.graphics.newImage("assets/bknight.png")
    image_bishop = love.graphics.newImage("assets/bishop.png")
    image_rook = love.graphics.newImage("assets/rook.png")
    image_queen = love.graphics.newImage("assets/queen.png")
    image_king = love.graphics.newImage("assets/king.png")
end

function random_enemy_generator()
    local rand_num = math.random(0, 5)
    if rand_num == 0 then
        return image_pawn
    elseif rand_num == 1 then
        return image_bknight
    elseif rand_num == 2 then
        return image_bishop
    elseif rand_num == 3 then
        return image_rook
    elseif rand_num == 4 then
        return image_queen
    elseif rand_num == 5 then
        return image_king
    end
end

function captured()
    score = score + 1
    enemy = random_enemy_generator()
    reset_timer()

    pos_x_enemy = math.random(0, WINDOW_WIDTH / BLOCK_WIDTH - 1)
    pos_y_enemy = math.random(1, WINDOW_WIDTH / BLOCK_WIDTH)
    while pos_x_enemy == pos_x_knight and pos_y_enemy == pos_y_knight do
        pos_x_enemy = math.random(0, WINDOW_WIDTH / BLOCK_WIDTH - 1)
        pos_y_enemy = math.random(1, WINDOW_WIDTH / BLOCK_WIDTH)
    end
end

function mode_change(changed_mode)
    if changed_mode == "easy" then
        BLOCK_WIDTH = 120 -- in pixels
        WINDOW_WIDTH = BLOCK_WIDTH * 5
        love.window.setMode(WINDOW_WIDTH, WINDOW_WIDTH + 100, {resizable=false})
    elseif changed_mode == "medium" then
        BLOCK_WIDTH = 100 -- in pixels
        WINDOW_WIDTH = BLOCK_WIDTH * 8
        love.window.setMode(WINDOW_WIDTH, WINDOW_WIDTH + 100, {resizable=false})
    elseif changed_mode == "hard" then
        BLOCK_WIDTH = 80 -- in pixels
        WINDOW_WIDTH = BLOCK_WIDTH * 12
        love.window.setMode(WINDOW_WIDTH, WINDOW_WIDTH + 100, {resizable=false})
    end
    block_count = WINDOW_WIDTH / BLOCK_WIDTH
end

function initial_spawn_pos()
    pos_x_knight = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2) - 1
    pos_y_knight = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
    pos_x_enemy = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
    pos_y_enemy = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
end