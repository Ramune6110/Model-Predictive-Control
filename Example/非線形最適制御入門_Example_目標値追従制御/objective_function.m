% objective_function
function f = objective_function(u_opt)
    global Control_dt t_int x_int T
    t  = t_int;
    x  = x_int;
   
    x_temp(1, :) = [x(1) x(2)];

    objfunc = 0;

    for k = 1:1:T
        t = t + Control_dt;
        u = u_opt(k, 1);

        x = Dynamics(x, u, Control_dt);

        x_temp(k + 1, :) = [x(1) x(2)];

        objfunc_dot = (x(1)^2 + x(2)^2 + u^2);
        objfunc     = objfunc + objfunc_dot * Control_dt;
    end

    f = 1 / 2 * (((x_temp(T + 1, 1))^2 + (x_temp(T + 1, 2))^2) + objfunc);
end

function x = Dynamics(xTrue, u, dt)
    f = [ (1 - xTrue(1)^2 - xTrue(2)^2) * xTrue(1) - xTrue(2) + u;
         xTrue(1)];
    x = xTrue + f.*dt;
end