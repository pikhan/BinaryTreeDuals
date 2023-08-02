function angles = get_angle(tree,root_id,start_angle,total_angle)
%total_angle is usually 180-300
%start_angle is usually 120-180
angles = containers.Map('KeyType','double','ValueType','any');
for i = 1:nnodes(tree)
    angles(i) = NaN;
end
% Initialize a queue with the root node
angle_increment = total_angle/(numel(tree.findleaves)+1);
leaf_iterator = 0;

it = traverse_left_to_right(tree,root_id);
disp("TESTER");
disp(it);
for i=it
    % If the node is a leaf, visit it
    disp("TEST");
    disp(i);
    disp(root_id);
    disp("TEST");
    if tree.isleaf(i)
        leaf_iterator=leaf_iterator+1;
        angles(i) = start_angle+leaf_iterator*angle_increment;
    elseif i==root_id | i==tree.getchildren(root_id)
        angles(i) = 90;
    end
end
while sum(~isnan(cell2mat(values(angles))))~=nnodes(tree)
    queue = [root_id];
    while ~isempty(queue)
        node = queue(1);
        queue(1) = [];
        children = tree.getchildren(node);
        truth=0;
        for i=1:length(children)
            truth=truth+~isnan(angles(children(i)));
        end
        if truth==length(children) && length(children)~=0
            average=0;
            for i=1:length(children)
                average=average+angles(children(i));
            end
            average=average/length(children);
            angles(node)=average;
        end
        % Add the children of the node to the back of the queue
        queue = [children, queue];
    end
end
end