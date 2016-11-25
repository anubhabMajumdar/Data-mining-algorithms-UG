%% Dataset 1
rng default; % For reproducibility
X = [randn(200,2)*0.75+ones(200,2);randn(200,2)*0.75-ones(200,2)];
%% Dataset 2
%rng default;  % For reproducibility
%load kmeansdata;
%% Dataset 3
% load fisheriris;
% X = meas(:,3:4);
%% plotting the data once
figure;
plot(X(:,1),X(:,2),'.');
title 'Randomly Generated Data';
%%
opts = statset('Display','final');

for k=2:4
   
    % --------------- k means --------------
    [idx,C] = kmeans(X,k,'Distance','cityblock',...
          'Replicates',5,'Options',opts);
    % --------------- DB/Dunn index calculation ------------
    % smaller DB, higher Dunn
    count = 1;
    for j=1:k
        cintra(j) = max(pdist(X(idx==j,:)));
        count = count+1;
    end
    interArray = pdist(C);
    cinter = squareform(interArray);
    [DB, Dunn] = valid_DbDunn(cintra, cinter, k);
    % ---------------- plot the data -------------------
    colormap(jet);
    figure;
    plot(X(:,1),X(:,2),'.');
    title(['K = ',num2str(k),' | DB = ',num2str(DB),' | Dunn = ',num2str(Dunn)]);
    hold on;
    for j=1:k
        scatter(X(idx==j,1),X(idx==j,2));
        plot(C(:,1),C(:,2),'kx',...
                  'MarkerSize',15,'LineWidth',3);
        %hold off
        
    end
end