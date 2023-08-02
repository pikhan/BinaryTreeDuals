function distance = get_distance_from_root(tree,child_id,root_id,scale)
    %first we will compute the depth of the child
    %scale is usually between 0.5 and 1
    depth=0;
    node_id=child_id;
    while node_id ~= root_id
        node_id=tree.getparent(node_id);
        depth=depth+1;
        disp(node_id);
    end
    distance=scale*((depth)/tree.depth);
end