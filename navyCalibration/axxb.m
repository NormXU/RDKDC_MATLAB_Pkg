function X = axxb( E_base_ee, E_cam_marker )
% E_base_ee: a Nx7 matrix that contain N forward kinematics
% measurements obtained from tf_echo. The format of each row must be
% [tx ty tz qx qy qz qw ]
% E_cam__marker: a Nx7 matrix that contain N AR tag measurements
% obtained from tf_echo. The format of each row must be
% [tx ty tz qx qy qz qw ]
% Return: the 4x4 homogeneous transformation of the hand-eye
% Attention: The sequence of Quanterion
% Written by Nuo Xu on March 3rd, 2018
[N,~] = size(E_base_ee);
A=[];
B=[];
% Ax = xB
for i = 1:N-1
    
Quat_base_ee1(1,1) = E_base_ee(i,7);
Quat_base_ee1(1,2:4) = E_base_ee(i,4:6);
R_base_ee1 = quat2rotm(Quat_base_ee1);
T_base_ee1 = E_base_ee(i,1:3)';
E_be1 = [R_base_ee1 T_base_ee1
         0 0 0 1];
 
Quat_base_ee2(1,1) = E_base_ee(i+1,7);
Quat_base_ee2(1,2:4) = E_base_ee(i+1,4:6);
R_base_ee2 = quat2rotm(Quat_base_ee2);
T_base_ee2 = E_base_ee(i+1,1:3)';
E_be2 = [R_base_ee2 T_base_ee2
         0 0 0 1];
     
A(:,:,i) = inv(E_be1)*E_be2;
Ra(:,:,i) = A(1:3,1:3,i);
Ta(:,i) = A(1:3,4,i);


% Convert into Euclidean Matrix
Quat_cam_marker1(1,1) = E_cam_marker(i,7);
Quat_cam_marker1(1,2:4) = E_cam_marker(i,4:6);
R_cam_marker1 = quat2rotm(Quat_cam_marker1);
T_cam_marker1 = E_cam_marker(i,1:3)';
E_cam_marker1 = [R_cam_marker1 T_cam_marker1
         0 0 0 1];

Quat_cam_marker2(1,1) = E_cam_marker(i+1,7);
Quat_cam_marker2(1,2:4) = E_cam_marker(i+1,4:6);
R_cam_marker2 = quat2rotm(Quat_cam_marker2);
T_cam_marker2 = E_cam_marker(i+1,1:3)';
E_cam_marker2 = [R_cam_marker2 T_cam_marker2
         0 0 0 1];
     
B(:,:,i) = (E_cam_marker1)*inv(E_cam_marker2);
Rb(:,:,i) = B(1:3,1:3,i);
Tb(:,i) = B(1:3,4,i);

alpha(:,i) = quat2skewsym(rotm2quat(Ra(:,:,i)));
beta(:,i) = quat2skewsym(rotm2quat(Rb(:,:,i)));
end

Rx=solveRx( alpha, beta );
tx=solveTx( Ra, Ta, Rb, Tb, Rx );
X = [Rx tx
     0 0 0 1];

end


function wtheta = quat2skewsym( quat )
% quat: a 1x4 vector representing a quaternion with the elements in
% the following order [x, y z, w].
% return: a 3x1 vector representing the skew symmetric matrix of the
% rotation [wx; wy; wz]

R = quat2rotm(quat);
fi = acos((trace(R)-1)/2);
w = fi/(2*sin(fi))*(R-R');
w1 = w(3,2);
w2 = w(1,3);
w3 = w(2,1);
wtheta = [w1;w2;w3];
end


function Rx=solveRx( alphas, betas )
% alphas: A 3xN matrix representing the skew symmetric matrices. That
% is, alphas = [α1 �?αN ]
% betas: A 3xN matrix representing the skew symmetric matrices. That
% is, betas = [β1 �?βN ]
% return: The least squares solution to the matrix Rx.
[~,N] = size(alphas);
M = zeros(3,3);
for i =1:N
    M = M+betas(:,i) * alphas(:,i)';
end
Rx=(M'*M)^(-1/2)*M';  
end


function tx=solveTx( RA, tA, RB, tB, RX )
% RA: a 3x3xN matrix with all the rotations matrices RAi
% tA: a 3xN matrix with all the translation vectors tAi
% RB: a 3x3xN matrix with all the rotations matrices RBi
% tB: a 3xN matrix with all the translation vectors tBi
% RX: the 3x3 rotation matrix Rx
% return: the 3x1 translation vector tx
I = eye(3);
[~,N] = size(tA);
C=[];
d=[];
%

for i = 1:N
    C = [C;I - RA(:,:,i)];
    d = [d;tA(:,i) - RX * tB(:,i)];
end

 tx = C\d;
end
