[attr,data] = import_arff('vote.arff');

%% parameter
total_count = 10;
attr_count = numel(attr)-1;
crossover_point = round(attr_count/randi([1,attr_count],[1,1]));
fitness_threshold = 0.1;
chromosome_count = 100;
chromosome_mutation_count = 2;
attr_mutation_count = 2;
fitness = zeros(chromosome_count,1);

%% make chromosomes
chromosomes = zeros(chromosome_count, numel(attr)-1);

%% randomly fill with 0/1
myVec = [0,0,0,0,0,0,0,1,1,1]; 

for i=1:chromosome_count
    for j=1:numel(attr)-1
        selectRand = randi(10,1); %choose the index
        finalValue = myVec(selectRand); %select that number from the original vector
        chromosomes(i,j) = finalValue;
    end
end


for k=1:total_count
    %% calculate fitness of each
    for i=1:chromosome_count
        cur_attr = {};
        temp = 1;
        for j=1:numel(attr)-1
            if chromosomes(i,j) == 1
                cur_attr{1,end+1} = j;
            end
        end
        fitness(i) = attribute_dependency(cur_attr,attr,data)/numel(find(chromosomes(i,:))==1);
    end

    %% eliminate those with fitness < thresh
    %del_index = [];
    for i=chromosome_count:-1:1
        if fitness(i) < fitness_threshold
            chromosomes(i,:) = [];
        end
    end

    %% crossover
    num_parents = numel(chromosomes(:,1));
    num_child = chromosome_count-num_parents;

    for i=1:num_child
        pn1 = randi([1,num_parents],[1,1]);
        pn2 = randi([1,num_parents],[1,1]);

        p1 = chromosomes(pn1,:);
        p2 = chromosomes(pn2,:);

        child = zeros(1,attr_count);
        child(1:crossover_point) = p1(1:crossover_point);
        child(crossover_point+1:end) = p1(crossover_point+1:end);
        chromosomes(num_parents+i,:) = child;

    end

    %% mutation

    for i=1:chromosome_mutation_count
        cur_chromosome = randi([1,chromosome_count],[1,1]);
        for j=1:attr_mutation_count
            cur_attr = randi([1,attr_count],[1,1]);
            chromosomes(cur_chromosome,cur_attr) = mod(chromosomes(cur_chromosome,cur_attr)+1,2);
        end
    end
    
    %% display
    disp(strcat('Iteration done -->',num2str(k)));
        
end

%% max gamma

index = find(fitness==max(fitness));
cur_attr = [];
for j=1:attr_count
    if chromosomes(index(1),j) == 1
        cur_attr(end+1) = j;
    end
end

%% result

numel(cur_attr)
cur_attr
max(fitness)



        