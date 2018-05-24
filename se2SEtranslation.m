function p = se2SEtranslation(w, v, theta)
% p = se2SEtranslation(w, v, theta)
% w is the skew symmetric matrix, the unit rotation axis, w should be 3X1
% theta is the magnitude;
% v is the translation unit direction, which should be 3X1;
% q is the point on the rotation axis; the coordinate of q is the all joint
% is zero, the coordinate with respect to base frame, q should be 3X1
p = ( ( eye(3)- so2SOrotation(w,theta) ) * skew(w) + w * w' *theta ) * v; 
end