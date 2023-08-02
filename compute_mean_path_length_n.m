function mean_path_length_n = compute_mean_path_length_n(dist)
    N = length(dist);
    mean_path_length_n = zeros(1, N);
    
    for n = 1:N
        % Exclude 'inf' values (which represent non-existent paths) and
        % zero values on the diagonal (which represent a node's path to itself)
        subgraph_dist = dist(1:n, 1:n);
        valid_paths = subgraph_dist(subgraph_dist ~= inf & subgraph_dist ~= 0);
        
        % Compute the mean path length for the subgraph containing the first n nodes
        mean_path_length_n(n) = sum(valid_paths) / length(valid_paths);
    end
end
