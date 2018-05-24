function matrixLogarithm = logMatrix(M) 
% Computer the log of square Matrix
% Written By Nuo Xu
  if 3 ~= size(M,1),
    error('Dimension:logMatrix','vector must be 3x1')
  end
  
m11 = M(1,1); m12 = M(1,2); m13 = M(1,3);
m21 = M(2,1); m22 = M(2,2); m23 = M(2,3);
m31 = M(3,1); m32 = M(3,2); m33 = M(3,3);
R=[m11 m12 m13; m21 m22 m23; m31 m32 m33];

fi = acos((trace(R)-1)/2);
w = fi/(2*sin(fi))*(R-R');
w1 = w(3,2);
w2 = w(1,3);
w3 = w(2,1);

matrixLogarithm = [w1; w2; w3];