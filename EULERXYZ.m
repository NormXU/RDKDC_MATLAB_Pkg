function R = EULERXYZ(v)
% accept one input - a 3-vector of angles (in radians)
% input vector = [Z_rotate_angle, Y_rotate_angle, X_rotate_angle]
% and returns the corresponding 3 x 3 rotation matrix
% this is ZYX Euler angles parameterizations; 
% Rotation sequence is: X --> Y --> Z

psii = v(1,1); theta = v(2,1); phi = v(3,1);
R = ROTX(phi) * ROTY(theta) * ROTZ(psii);
end