%Compute degree distributions and other metrics

function [degree_sequence, unique_degrees, degree_distribution, mean_deg, mean_deg_n] = compute_degrees(layout)
    % Initialize an array to store the degrees
    degrees = zeros(1, length(layout) + 1);

    % Iterate over each node in the graph
    for i = 1:length(layout)
        % The degree of a node is the number of connections it has
        degrees(i) = length(layout{i});
    end

    % Iterate over each node again to add the connections of each node to its connected nodes
    for i = 1:length(layout)
        for j = 1:length(layout{i})
            degrees(layout{i}{j}) = degrees(layout{i}{j}) + 1;
        end
    end
degree_sequence = sort(degrees, 'descend');
% Next, get the unique degrees and their counts
[unique_degrees, ~, degree_indices] = unique(degree_sequence);
degree_counts = accumarray(degree_indices, 1);

% Normalize the counts to get the degree distribution
degree_distribution = degree_counts / sum(degree_counts);
figure();
bar(unique_degrees, degree_distribution);
xlabel('Degree');
ylabel('Frequency');
title('Degree Distribution');
mean_deg = mean(degrees);
mean_deg_n = zeros(1, length(layout) + 1);
cum_sum_degrees = cumsum(degrees);
    
    % Iterate over each node in the graph
    for i = 1:length(layout)
        % The mean degree of the first n nodes is the cumulative sum of degrees divided by n
        mean_deg_n(i) = cum_sum_degrees(i) / i;
    end
    
    mean_deg_n(end) = mean_deg;  % The mean degree of all vertices is the mean degree we computed earlier
end





