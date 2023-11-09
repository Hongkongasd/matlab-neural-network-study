% Ìİ¶ÈÏÂ½µËã·¨
function optimal_x = gradientDescent(start_x, learning_rate, num_iterations)
    x = start_x;
    for i = 1:num_iterations
        grad = myGradient(x);
        x = x - learning_rate * grad;
    end
    optimal_x = x;
end
