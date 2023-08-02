%compute adjacency matrix
function adj = layout_to_adj(layout)
    n = length(layout) + 1;
    adj = inf(n);  % Initialize adjacency matrix with inf
    for i = 1:n-1
        for j = 1:length(layout{i})
            adj(i,layout{i}{j}) = 1;  % Set edge between i and layout{i}{j}
            adj(layout{i}{j},i) = 1;  % Set edge between layout{i}{j} and i
        end
    end
    % Set edge between first and last vertex
    adj(1,n) = 1;
    adj(n,1) = 1;
    % Set diagonal to 0
    for i = 1:n
        adj(i,i) = 0;
    end
end
