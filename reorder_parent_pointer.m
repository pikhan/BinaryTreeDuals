function pp_new = reorder_parent_pointer(pp_old, root_index)
    % Initialize the new parent pointer array
    pp_new = zeros(size(pp_old));
    
    % Define the shift amount
    shift_amount = root_index - 1;
    
    % Iterate over the old parent pointer array
    for i = 1:length(pp_old)
        % Calculate the new index
        new_index = mod(i - shift_amount - 1, length(pp_old)) + 1;
        
        if pp_old(i) == 0  % If this is the root
            % The root has no parent in the new parent pointer
            pp_new(new_index) = 0;
        else
            % Calculate the new parent index
            new_parent_index = mod(pp_old(i) - shift_amount - 1, length(pp_old)) + 1;
            
            % Assign the new parent index to the new parent pointer
            pp_new(new_index) = new_parent_index;
        end
    end
end
