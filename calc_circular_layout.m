% Define the function to calculate the circular layout of the tree, tree is
% of the matlab-tree class
function layout = calc_circular_layout(tree,root_id,start_angle,total_angle,scale,plotParam)
    angles = containers.Map('KeyType','double','ValueType','any');
    angleSelect = get_angle(tree,root_id,start_angle,total_angle);
    distances = containers.Map('KeyType','double','ValueType','any');
    queue = {root_id};
    leaf_iterator = 0;
    angles(root_id)=90;
    distances(root_id)=1;
    while ~isempty(queue)
        node = queue{1};
        queue(1) = [];
        children = tree.getchildren(node);
        for i = 1:length(children)
            child_id = children(i);
            angle=0;
            distance=0;
            if tree.isleaf(child_id)
                distance = 1;
                angle=angleSelect(child_id);
            elseif child_id==1
                distance = get_distance_from_root(tree,child_id,root_id,scale);
                angle = angleSelect(child_id);
            elseif isempty(child_id)
                disp("leaf");
            else
                distance = get_distance_from_root(tree,child_id,root_id,scale);
                angle = angleSelect(child_id);
            end
            angles(child_id) = angle;
            distances(child_id)=distance;
            queue{end+1} = child_id;
        end 
    end
anglevals=angles.values;
anglevalues=vertcat(anglevals{:});
distancevals=distances.values;
distancevalues=vertcat(distancevals{:});
layout={angles,distances};
if plotParam==1
    figure();
    % Plot the points
    polarplot(deg2rad(anglevalues), distancevalues, 'o', 'Color','blue');
    
    % Connect certain points with straight lines
    hold on;
    for i=1:tree.nnodes
        for j=1:tree.nnodes
            if i==tree.getparent(j) || j==tree.getparent(i)
                line([deg2rad(angles(i)), deg2rad(angles(j))], [distances(i), distances(j)],'Color','blue');
            end
        end
    end
    k = 1;
    theta = linspace(0,2*pi);
    rho = linspace(k,k);
    polarplot(theta,rho,'green');
    hold off;
% figure();
% [x, y] = pol2cart(transpose(deg2rad(anglevalues)), transpose(distancevalues));
% DT = delaunayTriangulation(x', y');
% triplot(DT);
% figure();
% [V, C] = voronoiDiagram(DT);
% % Extract the edges of the Delaunay triangulation that correspond to edges in the Voronoi diagram
% E = [];
% for i = 1:size(C, 1)
%     c = C{i};
%     n = length(c);
%     if n > 1
%         E = [E; c(1:n-1)', c(2:n)'];
%     end    
% end
% 
% % Plot the dual graph
% hold on;
% for i = 1:size(E, 1)
%     v1 = E(i, 1);
%     v2 = E(i, 2);
%     line([V(v1, 1), V(v2, 1)], [V(v1, 2), V(v2, 2)], 'Color', 'r', 'LineWidth', 2);
% end
% hold off;
% figure();
% % Compute the circle packing
% R = 1 ./ sqrt(1 - ((distancevalues)).^2);  % Compute radii of circles
% disp('tester2');
% C = [x', y'];  % Centers of circles
% disp(size(C));
% [~, E] = circle_packing(R, C);  % Compute dual graph
% 
% % Plot the dual graph
% hold on;
% for i = (1:size(E, 1))
%     v1 = E(i, 1);
%     v2 = E(i, 2);
%     line([C(v1, 1), C(v2, 1)], [C(v1, 2), C(v2, 2)], 'Color', 'r', 'LineWidth', 2);
% end
% hold off;
end
