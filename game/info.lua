require("game/util")

local info_screen = {}

local tenth = WINDOW_WIDTH/10

local close_button = {
    x = WINDOW_WIDTH - tenth,
    y = tenth/2,
    w = tenth/2,
    h = tenth/2
}

function info_screen.load()
    
end

function info_screen.update()
    
end

function info_screen.draw()
    love.graphics.setBackgroundColor(sky_blue)
    love.graphics.setFont(info_font)

    love.graphics.setColor(red)
    love.graphics.rectangle("fill", close_button.x, close_button.y, close_button.w, close_button.h)
    love.graphics.setColor(white)
    love.graphics.printf('X', close_button.x, close_button.y + close_button.w/4, close_button.w, "center")

    love.graphics.setFont(title_font)
    love.graphics.printf("How to Play", 0, tenth, WINDOW_WIDTH, "center")

    love.graphics.setFont(font)
    love.graphics.printf("Combine arrow keys (UP DOWN LEFT RIGHT) to move the knight piece", 0, 2.5*tenth, WINDOW_WIDTH, "center")

    love.graphics.setFont(info_message_font)
    love.graphics.printf("UP + LEFT: 2 blocks up 1 block left", 20, 4*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("UP + RIGHT: 2 blocks down 1 block right", 20, 5*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("DOWN + LEFT: 2 blocks down 1 block left", 20, 6*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("DOWN + RIGHT: 2 blocks down 1 block right", 20, 7*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("RIGHT + UP: 2 blocks right 1 block up", WINDOW_WIDTH/2 + 20, 4*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("RIGHT + DOWN: 2 blocks right 1 block down", WINDOW_WIDTH/2 + 20, 5*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("LEFT + UP: 2 blocks left 1 block up", WINDOW_WIDTH/2 + 20, 6*tenth, WINDOW_WIDTH/2, "left")
    love.graphics.printf("LEFT + DOWN: 2 blocks left 1 block down", WINDOW_WIDTH/2 + 20, 7*tenth, WINDOW_WIDTH/2, "left")
end

function info_screen.mousepressed(x, y, button)
    if isGameStarted == false then
        if button == 1 and x >= close_button.x and x <= close_button.x + close_button.w and y >= close_button.y and y <= close_button.y + close_button.h then
            isInfo = false
        end
    end
end

return info_screen