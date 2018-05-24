function g = expMatrix ( psi, magnitude )
%%%%%%%%%%%%%
% Compute the Matrix exponntial.
% psi =  [  w_hat   v   ]
%        [    0     0   ]
% Input is a matrix
% Written By Nuo Xu
%%%%%%%%%%%%%
w_hat = psi(1:3,1:3);
v = psi(1:3,4);
w = [w_hat(3,2);w_hat(1,3);w_hat(2,1)];
g = se2SE( w, v, magnitude);

end