fid = fopen('quick_reduct_sample.txt');
%fid = fopen('vote_discreet.csv');

%% Put core element in R
core = 'd';
T = {};
R = {core};

%% Read data and store it
tline = fgetl(fid);

attributes = cellstr(regexp(tline, '\,', 'split'));
C = attributes(1:end-1);

data = cell(1,numel(attributes));
tline = fgetl(fid);
i=1;
while ischar(tline)
    data(i,:) = cellstr(regexp(tline, '\,', 'split'));
    i = i + 1;
    tline = fgetl(fid);
end

%% quick reduct algorithm
found = 0;
while (~found)
    T = R;
    for i=1:numel(attributes)-1
        x = attributes(i);
        if ismember(x, R)
            continue;
        else
            temp = R;
            R(end+1) = x;
        end
        if attribute_dependency(R, attributes, data) > attribute_dependency(T, attributes, data) 
            T = R;
            if attribute_dependency(R, attributes, data) == 1
                found = 1;
                break;
            end
        else
            R = temp;
        end
    end
end


    
    
    
    
    
    
