% Optimizati
function out = Optimization(t_pre, x, xEnd, u_pre, param)
    global  Control_dt t_int u_int x_int x_end T
    t_int  = t_pre;
    x_int  = x;
    x_end  = xEnd;
    u_int  = u_pre;
    % 評価区間
    T  = param.T;
    % 予測区間
    Hu = param.Hu;
    % dt
    Control_dt = Hu / T;
    % 最適解解法(内点法)
    options = optimoptions('fmincon','Algorithm','Interior-point');
    % Initial parameter
    u0 = zeros(T, 2);
    u0(1 : T, 1) = u_int(1) * ones(T, 1);
    u0(1 : T, 2) = u_int(2) * ones(T, 1);
    % 評価関数を最小にする入力を求める fminconを使用
    % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
    A       = [];
    b       = [];
    Aeq     = [];
    beq     = [];
    lb      = ones(T, 1) * [-1.0 -0.5];
    ub      = ones(T, 1) * [1.0 0.5];
    nonlcon = [];
    u_opt = fmincon(@objective_function, u0, A, b, Aeq,beq, lb, ub, nonlcon, options);
    % 一番初めの要素を最終的な入力とする
    out = [u_opt(2, 1) u_opt(2, 2)];
end