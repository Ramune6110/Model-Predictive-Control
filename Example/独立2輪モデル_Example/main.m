% Receding Horizon Control　後退ホライズン
% Dynamics
% 独立二輪モデル

clear;
close all;
clc;

param = ModelParam();
% Initial condition
t     = param.ts;
xTrue = [param.x1; param.x2; param.x3];
xEnd  = [param.x1_end; param.x2_end; param.x3_end];
u     = [param.u1 param.u2];
% time
dt      = param.dt;
endtime = param.tf;
nsteps  = ceil((endtime - t) / dt);
t_vec   = size(t:dt:endtime);
t_pre   = t;
u_pre   = u;
% save data
result.xTrue = [];
result.time  = [];
result.u     = [];
result.xTrue = [result.xTrue; xTrue'];
result.time  = [result.time; t];
result.u     = [result.u; u];

% loop
tic;
for i = 1:nsteps
    t = t + dt;
    u = Optimization(t_pre, xTrue, xEnd, u_pre, param);
    xTrue = Dynamics(xTrue, u, dt);
    
    t_pre = t;
    u_pre = u;
    % save data
    result.xTrue = [result.xTrue; xTrue'];
    result.time  = [result.time; t];
    result.u     = [result.u; u];
end
toc;
% Graph
DrowGraph(result, endtime, t_vec);

function x = Dynamics(xTrue, u, dt)
    f = [u(1) * cos(xTrue(3));
         u(1) * sin(xTrue(3));
         u(2)];
    x = xTrue + f.*dt;
end