function R = ROTY(phi)
% Rotate around Y axis with Phi
R = [cos(phi)  0   sin(phi);
     0  1  0;
     -sin(phi) 0 cos(phi)
    ];
end