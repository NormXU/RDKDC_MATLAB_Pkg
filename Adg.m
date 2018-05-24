function Adg = Adg(R,p)
% Input is R and p
% v_S              v_b
%      =    Adg *  
% w_S              w_b
  if 3 ~= size(p,1),
    error('Dimension:Adg','translation vector must be 3x1')
  end
  Adg = [R skew(p) * R
        zeros(3,3) R];
    
end