function [class]= part(partitionAttr,attributes,data)

[row,~]=size(data);
numPart = numel(partitionAttr);
numAttr = numel(attributes);

%% returns the column numbers of the attributes wrt which we want to parcolumnNo = [];
count =1;
clear columnNo
for i=1:numPart
    for j=1:numAttr
        if partitionAttr{i}==attributes{j}
            columnNo(count)=j;
            count = count +1;
            break;
        end
    end
end


%% getting the unique values wrt those attributes
clear uMat;
%uMat = repmat('',[numel(data),numPart]);
for i=1:numPart   
   x=char(data(:,columnNo(i)));
   if numel(x(1,:))>1
    uMat(:,i)=x(:,2);
   else
    uMat(:,i)=x;
   end
end

uniqueUMat = unique(uMat,'rows');
[numUnique,~]=size(uniqueUMat);

%% getting different classes
clear class
for i=1:numUnique
    count = 1;
    for j=1:row
        if strcmp(uniqueUMat(i,:),uMat(j,:))
            class{i,count}=j;  
            count = count+1;
        end
    end
end
%class
%% cleaning the class data
% [num,max]=size(class);
% for i=1:num
%     for j=1:max
%         if isempty(class{i,j})
%             
%         end
%     end
end



%end


