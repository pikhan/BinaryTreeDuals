% Define the function to draw the tree using the circular layout
function draw_tree(root, layout)
    figure;
    hold on;
    for i = 1:length(layout)
        node = layout.keys{i};
        pos = layout(node);
        x = pos(2)*cosd(pos(1));
        y = pos(2)*sind(pos(1));
        parent = get_parent(node);
        if ~isempty(parent)
            parent_pos = layout(parent);
            parent_x = parent_pos(2)*cosd(parent_pos(1));
            parent_y = parent_pos(2)*sind(parent_pos(1));
            line([parent_x, x], [parent_y, y], 'LineWidth', 2);
        end
        scatter(x, y, 'filled');
        text(x, y, node);
    end
    axis equal;
    hold off;
end
