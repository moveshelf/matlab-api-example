function fok = d2s(d)

% function to transform py.dict in matlab struct
% also eliminates the node from json data 
fok = struct(struct(d).node);