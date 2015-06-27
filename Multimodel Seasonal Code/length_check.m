long = 0;
longest = 0;
for iter = 1:1:length(max_idx)-1
    if max_idx(iter)==max_idx(iter+1)
        long = long + 1;
    else
        if long > longest
            longest = long;
        end
        long = 0;
    end
end

hold on;
plot(Xs(max_test_idx==1,2),ys(max_test_idx==1),'*b')
plot(Xs(max_test_idx==2,2),ys(max_test_idx==2),'*g')
plot(Xs(max_test_idx==3,2),ys(max_test_idx==3),'*r')
