% Generate a random SE3 transformation
function Rt = randSE3()
% Generate a random rotation matrix
[R,~] = qr(randn(3));
% Generate a random translation
 t = randn(3,1);
Rt = [ R t; 0 0 0 1];
end