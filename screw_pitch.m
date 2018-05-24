function h = screw_pitch(w,v)
  if 3 ~= size(w,1) ||  3 ~= size(v,1),
    error('Dimension:screw_pitch','w vector and v vector must be 3x1')
  end
  h = (w' * v) / (w' * w);
end