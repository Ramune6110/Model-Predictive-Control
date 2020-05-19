% objective_function
function f = objective_function(xopt)
    global Control_dt t_int x1_int x2_int u_int 
    t  = t_int;
    x1 = x1_int;
    x2 = x2_int;
    u  = u_int;

    table(1, :) = [t x1 x2 u];

    objfunc = 0;

    for k = 1:1:30
        t = t + Control_dt;
        u = xopt(k, 1);

        x1_dot = (1 - (x1)^2 - (x2)^2) * x1 - x2 + u;
        x2_dot = x1;

        x1 = x1 + x1_dot * Control_dt;
        x2 = x2 + x2_dot * Control_dt;

        table(k + 1, :) = [t x1 x2 u];

        objfunc_dot = (x1^2 + x2^2 + u^2);
        objfunc     = objfunc + objfunc_dot * Control_dt;
    end

    f = 1 / 2 * (((table(30+ 1, 2))^2 + (table(30 + 1, 3))^2) + objfunc);
end