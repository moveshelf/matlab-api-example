function fok = py2mat(field)

fc = class(field);

switch fc
    case 'py.str'
        fok = s2s(field);
    case 'py.dict'
        fok = struct(field);
        if strcmp(fieldnames(fok), "node")
            fok = d2s(field);
        end
    case 'py.list'
        fl = cell(field);
        for i = 1: length(fl)
            fok(i) = py2mat(fl{i});
        end        
end


