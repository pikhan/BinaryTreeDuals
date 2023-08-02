function output = traverse_left_to_right(tree, id)
    output = [];
    if ~(tree.isleaf(id))
        children = tree.getchildren(id);
        for i = 1:length(children)
            output = [output, traverse_left_to_right(tree, children(i))];
        end
    end
    output = [output, id];
    fprintf('%d ', id);
end
