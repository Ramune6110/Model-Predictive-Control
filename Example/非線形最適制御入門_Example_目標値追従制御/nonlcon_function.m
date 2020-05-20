function [c, ceq] = nonlcon_function(u_opt)
    % c   = Nonlinear inequality constraints(”ñüŒ`•s“™®§–ñ)
    % ceq = Nonlinear equality constraints(”ñüŒ`“™®§–ñ)
    global t_int x_int x_end dt T

    t = t_int;
    x = x_int;
    
    for k = 1:1:T
        t = t + dt;
        u = u_opt(k, 1);
        x = Dynamics(x, u, dt);
    end
    c   = [];
    ceq = [x(1) - x_end(1) x(2) - x_end(2)];   
end

function x = Dynamics(xTrue, u, dt)
    f = [ (1 - xTrue(1)^2 - xTrue(2)^2) * xTrue(1) - xTrue(2) + u;
         xTrue(1)];
    x = xTrue + f.*dt;
end
    
    
    