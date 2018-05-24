function col = vee( psi )
N = size(psi,1);
v = psi(1:N-1,N);
w = psi( 1:N-1, 1:N-1 );
w1 = w(3,2); w2 = w(1,3); w3 = w(2,1);
col = [v; w1;w2;w3];
end