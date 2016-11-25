function [attr,data] = import_arff(filename)

f = fopen(filename);
flag = 0;
count = 1;

x = fgets(f);

while(ischar(x))
%     
%     fwrite(f2, char(m{end}));
    if ~strcmp(x(1),'%') && ~strcmp(x(1),'@')
       m = regexp(x, ',', 'split');
       if flag == 0
           l = numel(m);
           data = cell(1,l);
           flag = 1;
       end
       data(count,:) = m;
       count = count + 1;
    end
    x = fgets(f);
end

fclose('all');

%%

for i=1:numel(data)/l
    x = char(data(i,end));
    data(i,end) = {x(2)};
    
end

%%

attr = cell(1,l);
for i=1:l
    attr(i) = {i};
end

end