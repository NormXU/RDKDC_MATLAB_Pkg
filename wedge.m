function psi = wedge( col )
w = col(4:6,1);
v = col(1:3,1);
psi = [skew(w) v
    0 0 0 1];

end