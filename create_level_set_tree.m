function tree = create_level_set_tree(time_series)
    % Define some parameters for the kernel density estimation
    bandwidth = 1.06 * std(time_series) * length(time_series)^-0.2;
    [density, x] = ksdensity(time_series, 'BandWidth', bandwidth);
    
    % Sort the density in descending order
    [density_sorted, sorted_idx] = sort(density, 'descend');
    x_sorted = x(sorted_idx);

    % Create the root node
    root = struct('parent', 0, 'children', [], 'x', x_sorted(1), 'density', density_sorted(1));
    tree = [root];

    for i = 2:length(x_sorted)
        % Find the parent node
        parent_idx = find([tree.density] < density_sorted(i), 1, 'first');

        % Create a new node with the parent node as its parent
        new_node = struct('parent', parent_idx, 'children', [], 'x', x_sorted(i), 'density', density_sorted(i));
        tree = [tree; new_node];

        % Add the new node as a child of its parent node
        tree(parent_idx).children = [tree(parent_idx).children, length(tree)];
    end
end
