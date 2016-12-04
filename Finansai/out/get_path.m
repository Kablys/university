function r = get_path(s)
%gets path only from full file location

idx = find(s=='\',1,'last');

if isempty(idx)
    r = '';
    return
end;

r = s(1:idx);
