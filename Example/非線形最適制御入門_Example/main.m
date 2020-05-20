% Receding Horizon Control　後退ホライズン
% Dynamics
% x1_dot = (1-(x1)^2-(x2)^2)*x1 - x2 +u
% x2_dot = x1

clear;
close all;
clc;

param = ModelParam();
% Initial condition
t     = param.ts;
xTrue = [param.x1; param.x2];
xEnd  = [param.x1_end; param.x2_end];
u     = param.u;
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
    f = [ (1 - xTrue(1)^2 - xTrue(2)^2) * xTrue(1) - xTrue(2) + u;
         xTrue(1)];
    x = xTrue + f.*dt;
end