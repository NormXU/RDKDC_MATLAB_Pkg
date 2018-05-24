function v = EULERXYZINV( R )
% accepts a 3 x 3 rotation matrix and returns a 3 x 1 vector (in radians)

% since xgma = atan2(r32,r33); phi = atan2(r21,r11); when r11=r21=0; 
% or when r33=r32=0 ; 0/0 has no meaning in math, 
% In this circumstance, the function EULERXYZINV(R) is ill-defined
% Also, we need to consider the singularity point/
% Since Z --> Y --> X. when Y rotate |pi/2|, Z and X will be in the same plane
% In this circumstace, we lose one DoF, this is Gimbal Lock(Singularity)
r11 = R(1,1); r12 = R(1,2); r13 = R(1,3);
r21 = R(2,1); r22 = R(2,2); r23 = R(2,3);
r31 = R(3,1); r32 = R(3,2); r33 = R(3,3);
if ( (r32 == 0 && r33 == 0) || (r21 == 0 && r11 ==0))
    warning('the function EULERXYZINV(R) is ill-defined');
    if (r31 == +1) % r31 = -sin(theta), that is, theta = -pi/2
        % under this circumstance; r22 = cos(phi+xgma); r23 = -sin(phi+xgma)
        % let phi = 0; xgma = arctan(-r23,r22)
        v = [0;-pi/2;atan2(-r23,r22)];
        % output vector = [Z_rotate_angle; Y_rotate_angle; X_rotate_angle]
    end
    if (r31 == -1)% r31 = -sin(theta), that is, theta = +pi/2
        % under this circumstance; r22 = cos(phi-xgma); r23 = sin(phi-xgma)
        % let xgma = 0; phi = arctan(r23,r22)
        v = [0;pi/2;atan2(r12,r13)];
    end
else

    theta1 = -asin(r31);
    theta2 = pi - theta1;
    phi1 = atan2(r32/cos(theta1),r33/cos(theta1));
    phi2 = atan2(r32/cos(theta2),r33/cos(theta2));
    psii1 = atan2(r21/cos(theta1),r11/cos(theta1));
    psii2 = atan2(r21/cos(theta2),r11/cos(theta2));
    angle1 = [psii1;theta1;phi1]
    angle2 = [psii2;theta2;phi2]
    v = [angle1 angle2]; %
    % There are two solution set, angle1 and angle2
end
% output vector = [Z_rotate_angle; Y_rotate_angle; X_rotate_angle]
end