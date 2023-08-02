function faceEdgeList = populateFaces(tree,leafkeys)
faceEdgeList = cell(length(leafkeys),1);
%assuming that our leafkeys are sorted
j=1;
while j~=length(leafkeys)+1
    faceNum=0;
    leaf1=0;
    leaf2=0;
    if j~=length(leafkeys)
        faceNum=j+1;
        leaf1 = leafkeys(j+1);
        leaf2 = leafkeys(j);
    end
    if j==length(leafkeys) %condition for the last leaf connecting to the root
        leaf1=leafkeys(j);
        leaf2=leafkeys(1);
        faceNum=1;
    end
    % Starting from the first leaf, compute its parent node and add it to a list
    % of visited nodes. Repeat until you reach the root of the tree.
    
    visited1 = {leaf1};
    if leaf1~=1
        parent1 = tree.getparent(leaf1);
        while ~isequal(parent1, 1)
            visited1 = [visited1, parent1];
            parent1 = tree.getparent(parent1);
        end
        visited1 = [visited1, 1];  % add the root node to the list
    end

    
    % Do the same for the second leaf and add its parent nodes to a separate list
    % of visited nodes.
    visited2 = {leaf2};
    if leaf2~=1
        parent2 = tree.getparent(leaf2);
        while ~isequal(parent2, 1)
            visited2 = [visited2, parent2];
            parent2 = tree.getparent(parent2);
        end
        visited2 = [visited2, 1];  % add the root node to the list
    end
    visited1=cell2mat(visited1);
    visited2=cell2mat(visited2);
    disp(visited1);
    disp(visited2);
    % Compare the two lists of visited nodes and find the common node where they
    % intersect.
    common_node = max(intersect(visited1, visited2));
    disp(common_node);

    index1 = find(visited1 == common_node);
    disp(index1);
    visited1 = visited1(1:index1-1); %get rid of common node as we dont actually traverse that node's correspondent edge.
    disp(visited1);
    
    % Append the visited nodes from the common node to the second leaf to the end
    % of the list.
    index2 = find(visited2 == common_node);
    visited1 = [visited1, visited2(index2-1:-1:1)];
    
    % Return the list of visited nodes.
    path = visited1;

    faceEdgeList{faceNum,1}=path;
    j=j+1;
end
