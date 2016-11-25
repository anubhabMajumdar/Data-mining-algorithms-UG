function [gamma]= attribute_dependency(partition, attributes, data)
D = attributes(end);

%% get the classes using part() function
class_D = part(D,attributes,data);
class_partition = part(partition,attributes,data);

%% cell to array
[num_D,max_D] = size(class_D);
[num_partition,max_partition] = size(class_partition);

D_row = zeros(num_D, max_D);
partition_row = zeros(num_partition, max_partition);

for i=1:num_D
    for j=1:max_D
        if ~isempty(class_D{i,j})
            D_row(i,j) = class_D{i,j};
        end
    end
end

for i=1:num_partition
    for j=1:max_partition
        if ~isempty(class_partition{i,j})
            partition_row(i,j) = class_partition{i,j};
        end
    end
end

%% finding which of class_partition is a complete subset of class_D
count_elements = 0;

for i=1:num_D
    cur_D = D_row(i,:);
    for j=1:num_partition
        cur_partition = partition_row(j,:);
        diff = setdiff(cur_partition, cur_D);
        if isempty(diff) || nnz(diff)==0
            count_elements = count_elements + nnz(cur_partition);
        end
    end
end

%% compute gamma
[data_size,~] = size(data);
gamma = count_elements/data_size;

end