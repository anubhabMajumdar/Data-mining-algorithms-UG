[r,c,t] = size(data_without_noise);

out = zeros(t,r*c);

for i=1:t
    out(i,:) = reshape(data_without_noise(:,:,i),[1,r*c]);
end
%%
kval = 10;
n = 10;
f = zeros(kval-1,1);
temp = zeros(n,1);
for i=2:kval
    for j=1:n
        x = kmeans(out,i);
        temp(j) = indexDN(out,x,[]);
    end
    f(i) = max(temp);    
end
%%
f