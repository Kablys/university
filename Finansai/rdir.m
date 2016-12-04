function files = rdir(path,option)
%advanced dir with 'recursive' option

if ~exist('option','var') || isempty(option)
    option = 'simple';
end

if ischar(path)
    files = rdir2([],path,option);
end

if iscell(path)
    files = [];
    for i=1:length(path)
        files = [files;rdir2([],path{i},option)];
    end
end
    
return

function files = rdir2(files,path,option)

%get files
files2 = dir(path);
for i=1:length(files2)
    files2(i).full_name = [get_path(path) files2(i).name];
end

if ~isempty(files2)
    files = [files;files2];
end

%get dir and recurse
if strcmp(option,'recursive') == 1
    files2 = dir(get_path(path));
    for i=1:length(files2)
        if files2(i).isdir && ~ismember(files2(i).name,{'.','..'})
            p2 = [get_path(path) files2(i).name '\' get_file(path)];
            files = rdir2(files,p2,option);
        end
    end
end