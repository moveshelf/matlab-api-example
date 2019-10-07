function fok = l2s(l)

% function to transform py.list in matlab struct
fc = cell(l);
for i = 1:length(fc)
    if (strcmp(class(fc{i}),'py.str') == 1)
        fok(i) = s2s(fc{i});
    elseif (strcmp(class(fc{i}),'py.dict') == 1)
        fok(i) = d2s(fc{i});
    end
end
