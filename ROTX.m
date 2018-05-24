function R = ROTX(phi)
% Rotate around X axis with Phi
R = [1  0   0;
     0  cos(phi)  -sin(phi);
     0  sin(phi)  cos(phi)
    ];
end