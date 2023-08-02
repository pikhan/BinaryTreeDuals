%floyd-warshall algorithm for computing average path length
function [dist, apl] = floyd_warshall(adj)
    n = size(adj,1);
    dist = adj;
    for k = 1:n
        for i = 1:n
            for j = 1:n
                if dist(i,k) + dist(k,j) < dist(i,j)
                    dist(i,j) = dist(i,k) + dist(k,j);
                end
            end
        end
    end
apl = sum(sum(dist))/(n*(n-1));
end