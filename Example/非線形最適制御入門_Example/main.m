% Receding Horizon Control　後退ホライズン
% Dynamics
% x1_dot = (1-(x1)^2-(x2)^2)*x1 - x2 +u
% x2_dot = x1

clear;
close all;
clc;

param = ModelParam();
% Initial condition
t  = param.ts;
x1 = param.x1;
x2 = param.x2;
u  = param.u;
% time
dt      = param.dt;
endtime = param.tf;
nsteps  = ceil((endtime - t) / dt);
t_vec   = size(t:dt:endtime);
t_pre   = t;
u_pre   = u;
% save data
result.x1   = [];
result.x2   = [];
result.time = [];
result.u    = [];
result.x1   = [result.x1; x1];
result.x2   = [result.x2; x2];
result.time = [result.time; t];
result.u    = [result.u; u];

% loop
tic;
for i = 1:nsteps
    t = t + dt;
    u = Optimization(t_pre, x1, x2, u_pre, param);
    
    x1_dot = (1 - (x1)^2 - (x2)^2) * x1 - x2 + u;
    x2_dot = x1;
    x1     = x1 + x1_dot * dt;
    x2     = x2 + x2_dot * dt;
    
    t_pre = t;
    u_pre = u;
    % save data
    result.x1   = [result.x1; x1];
    result.x2   = [result.x2; x2];
    result.time = [result.time; t];
    result.u    = [result.u; u];
end
toc;

% Figure
figure(1)
subplot(3, 1, 1);
plot(result.time, result.x1,'k','Linewidth',1); hold on; grid on;
xlim([0 endtime]);
xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
ylabel('{\itx}_{1}({\itt})','FontName','Times New Roman','Fontsize',10.5)

subplot(3, 1, 2);
plot(result.time, result.x2,'k','Linewidth',1); hold on; grid on;
xlim([0 endtime]);
xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
ylabel('{\itx}_{2}({\itt})','FontName','Times New Roman','Fontsize',10.5)

subplot(3, 1, 3);
plot(result.time, result.u,'k','Linewidth',1); hold on;
plot(result.time, 0.5 * ones(t_vec(2), 1), '--r'); hold on;
plot(result.time, -0.5 * ones(t_vec(2), 1), '--r'); hold on;
xlim([0 endtime]); ylim([-1 1]); grid on;
xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
ylabel('{\itu}({\itt})','FontName','Times New Roman','Fontsize',10.5)