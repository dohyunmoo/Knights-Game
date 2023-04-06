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
    pos_x_knight = 4
    pos_y_knight = 4
    pos_x_pawn = 3
    pos_y_pawn = 2
    MAX_TIME_CURRENT_ROUND = 10

    score = 0
    time_left = MAX_TIME_CURRENT_ROUND
end