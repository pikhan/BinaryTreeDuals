%clustering coefficients
function [clustering_coefficients, mean_clustering_coefficient] = compute_clustering_coefficient(adj_matrix)
N = length(adj_matrix);
clustering_coefficients = zeros(1, N);

for i = 1:N
    adj_matrix(isinf(adj_matrix)|isnan(adj_matrix)) = 0;
    neighbors = find(adj_matrix(i, :)); % get the indices of the neighbors
    N_i = length(neighbors); % number of neighbors
    if N_i > 1 % only consider nodes with at least two neighbors
        E_i = sum(sum(adj_matrix(neighbors, neighbors))) / 2; % number of edges between neighbors
        clustering_coefficients(i) = 2 * E_i / (N_i * (N_i - 1));
    end
end

mean_clustering_coefficient = mean(clustering_coefficients);