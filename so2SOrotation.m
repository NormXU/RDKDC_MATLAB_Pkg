function R = so2SOrotation(w,theta)
% R = so2SOrotation(w,theta)
% translation from so(3) to SO(3)
% w is the unit rotation axis, theta is the magnitude
% w should be 3X1
  if 3 ~= size(w,1),
    error('DIMENSION:w','vector must be 3x1')
  end
I = eye(3);
R = I + skew(w) * sin(theta) + skew(w)*skew(w) * (1-cos(theta));
end