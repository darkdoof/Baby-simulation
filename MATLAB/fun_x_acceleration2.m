function a = fun_x_acceleration2(x, y, v, u)

g = 9.82;               % gravitation [m/s^2]
m = 9.0;                % weight [kg] 
k = 145.5;              % spring constant [N/m]
b = 8.0;                 % dampening [Ns/m]
kick_force_constant = 15;% dimensionless constant
angleR = 3*pi/8;        % kick angle right leg
angleL = 5*pi/8;        % kick angle left leg

bandR_start = [-0.2, 2.0]; % where the elastic band is fixed
bandR_end = [-0.1, 0.0];
bandL_start = [0.2, 2.0]; % where the elastic band is fixed
bandL_end = [0.1, 0.0];

band_length = pdist([bandR_start; bandR_end], 'euclidean');
band_stretch_R = pdist([bandR_start; x,y], 'euclidean');
band_stretch_L = pdist([bandL_start; x,y], 'euclidean');

stretch_dist_R = band_length - band_stretch_R;
stretch_dist_L = band_length - band_stretch_L;

if(stretch_dist_R > 0)
    stretch_dist_R = 0;
end
if(stretch_dist_L > 0)
    stretch_dist_L = 0;
end

thetaR = atan2((bandR_start(2)-(y-bandR_end(2))),(bandR_start(1)-(x-bandR_end(1))));
thetaL = atan2((bandL_start(2)-(y-bandL_end(2))),(bandL_start(1)-(x-bandL_end(1))));

ux = u(1,1)*cos(angleR)*kick_force_constant*(1-(exp(min(y,0)))) ...
    + u(2,1)*cos(angleL)*kick_force_constant*(1-(exp(min(y,0))));

a = (1/m)*(ux - k*cos(thetaR)*stretch_dist_R - k*cos(thetaL)*stretch_dist_L ...
    - b*v);
end

