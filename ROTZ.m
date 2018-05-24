function R = ROTZ(phi)
% Rotate around Z axis with Phi
R = [
     cos(phi)  -sin(phi) 0;
     sin(phi)  cos(phi) 0;
     0   0   1
    ];
end