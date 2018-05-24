function E = se2SE(w, v, theta)
% E = se2SE(w, v, theta)
% w is the skew symmetric matrix, the unit rotation axis, w should be 3X1
% theta is the magnitude;
% v is the translation unit direction, which should be 3X1;
% return E is a homogeneous matrix
% Written By Nuo Xu
R = so2SOrotation(w, theta);
p = se2SEtranslation(w,v,theta);
E = [R p
    0 0 0 1];
end