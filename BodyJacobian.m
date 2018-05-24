function J = BodyJacobian( psi_vector, joint_vector, gst0 )
%%%%%%%%%%%%%
% Compute the Jacobian matrix 
% Input psi_vector:6 x N; joint_vector: 6 joints; gst0: Initial
% Configuration
% Written By Nuo Xu
%%%%%%%%%%%%%
PSI = cell(6,1);

for k = 1:6
psi_w = psi_vector( 4:6, k );
psi_v = psi_vector( 1:3, k );
PSI{k,1} = [skew( psi_w ) psi_v; 0 0 0 0];
end


 J = [];

for i= 1:6
    j = i;
    G = eye(4);
    while j <= 6
      G = G * expMatrix( PSI{j,1} , joint_vector(j,1) );
      j = j+1;
    end
    G = G * gst0;
    tmp = (G \ PSI{i,1}) * G;
    j_psi = [tmp(1:3,4);tmp(3,2);tmp(1,3);tmp(2,1)];
    J = [J j_psi];
end

end