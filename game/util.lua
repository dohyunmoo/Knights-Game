require("conf")

function init()
    WINDOW_WIDTH = BASE_WINDOW_WIDTH
    WINDOW_HEIGHT = BASE_WINDOW_HEIGHT
    BASE_BLOCK_WIDTH = 100
    
    font_size = 24
    
    black = {0, 0, 0}
    white = {tonumber("ff", 16)/255, tonumber("ff", 16)/255, tonumber("ff", 16)/255}
    yellow = {tonumber("ff", 16)/255, tonumber("dd", 16)/255, tonumber("00", 16)/255}
    blue = {tonumber("0a", 16)/255, tonumber("11", 16)/255, tonumber("72", 16)/255}
    sky_blue = {tonumber("63", 16)/255, tonumber("c5", 16)/255, tonumber("da", 16)/255}
    red = {tonumber("e3", 16)/255, tonumber("24", 16)/255, tonumber("2b", 16)/255}
    
    highscore_easy = 0
    highscore_medium = 0
    highscore_hard = 0

    isInfo = false
end

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

    isInfo = false

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
    local rand_num = math.random(0, 15)
    if rand_num >= 0 and rand_num < 8 then
        return image_pawn
    elseif 8 <= rand_num and rand_num < 10  then
        return image_bknight
    elseif 10 <= rand_num and rand_num < 12 then
        return image_bishop
    elseif 12 <= rand_num and rand_num < 14 then
        return image_rook
    elseif rand_num == 14 then
        return image_queen
    elseif rand_num == 15 then
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

    if mode == "easy" and score >= highscore_easy then
        highscore_easy = score
    elseif mode == "medium" and score >= highscore_medium then
        highscore_medium = score
    elseif mode == "hard" and score >= highscore_hard then
        highscore_hard = score
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
    isGameStarted = true
    time_left = MAX_TIME_CURRENT_ROUND
    initial_spawn_pos()
    block_count = WINDOW_WIDTH / BLOCK_WIDTH
    mode = changed_mode
end

function initial_spawn_pos()
    pos_x_knight = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2) - 1
    pos_y_knight = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
    pos_x_enemy = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
    pos_y_enemy = math.floor((WINDOW_WIDTH / BLOCK_WIDTH) / 2)
end
