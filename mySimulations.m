%simulations
function sim = mySimulations()
%First, let us generate a uniformly distributed random time series
time_series = rand(1,100); % a time series of 100 uniformly distributed random numbers
levelSetTree = level_set_tree(time_series,[1:100],0); %our level set tree, code from Zoe Haskell's Ph.D thesis

% Find the indices where the list has the value 0
root_index = find(levelSetTree == 0);
lvlTreeParentPointer = reorder_parent_pointer(levelSetTree, root_index);
lvlTree = tree(lvlTreeParentPointer);
%let's plot the level set tree
figure();
treeplot(levelSetTree);
figure();
lvlTree.plot;
%compute some simulations
treelayout = calc_circular_layout(lvlTree,1,120,300,0.75,1);
layout = calc_dual_layout(lvlTree,treelayout,1);
[degree_sequence, unique_degrees, degree_distribution, mean_deg, mean_deg_n] = compute_degrees(layout);
disp(degree_sequence);
disp(unique_degrees);
disp(degree_distribution);
disp(mean_deg);
disp(mean_deg_n);
adj = layout_to_adj(layout);
[dist, apl] = floyd_warshall(adj);
disp(apl);
mean_path_length_n = compute_mean_path_length_n(dist);
disp(mean_path_length_n);
[clustering_coefficients, mean_clustering_coefficient] = compute_clustering_coefficient(adj);
disp(clustering_coefficients);
disp(mean_clustering_coefficient);
sim = 1;
