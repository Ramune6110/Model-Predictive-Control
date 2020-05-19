% Optimization
function out = Optimization(t_pre, x1, x2, u_pre, param)
    global  Control_dt t_int x1_int x2_int u_int 
    t_int  = t_pre;
    x1_int = x1;
    x2_int = x2;
    u_int  = u_pre;
    % �\�����
    Hu = param.Hu;
    % dt
    Control_dt = Hu / param.T;
    % �œK����@(���_�@)
    options = optimoptions('fmincon','Algorithm','Interior-point');
    % Initial parameter
    x0 = zeros(param.T, 1);
    x0(1 : param.T, 1) = u_int;
    % �]���֐����ŏ��ɂ�����͂����߂� 
    % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
    A       = [];
    b       = [];
    Aeq     = [];
    beq     = [];
    lb      = -0.5 * ones(param.T, 1);
    ub      = 0.5 * ones(param.T, 1);
    nonlcon = [];
    xopt = fmincon(@objective_function, x0, A, b, Aeq,beq, lb, ub, nonlcon, options);
    % ��ԏ��߂̗v�f���ŏI�I�ȓ��͂Ƃ���
    out = xopt(2, 1);
end