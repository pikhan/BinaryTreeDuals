function [C, E] = circle_packing(R, C)
% CIRCLE_PACKING Compute a circle packing and its dual graph.
%   [C, E] = CIRCLE_PACKING(R, C) computes a circle packing with radii R
%   and centers C, and returns the dual graph of the packing as a list of
%   edges E. The centers of the circles are given by the rows of C.

n = size(C, 1);  % Number of circles
E = [];  % List of edges

% Compute distances between circle centers
D = sqrt(sum((reshape(C, [n,1,2]) - reshape(C, [1,n,2])).^2, 3));% Compute minimum and maximum radii
rmin = min(R);
rmax = max(R);

% Replace Inf values in R with max(R(isfinite(R))) + 1
%R(isinf(R)) = max(R(isfinite(R))) + 1;

% Compute overlap distances
Rsum = bsxfun(@plus, R, R.');
Ravg = Rsum / 2;
disp("tester");
disp(size(D));
delta = D-(R+R')/2;
%delta(1:n+1:end) = 0;

% Compute overlap angles
theta = zeros(n);
for i = 1:n
    for j = i+1:n
        if delta(i,j) < 0
            % Circles i and j overlap
            if D(i,j) < (R(i) + R(j))
                % Circle i is contained in circle j
                theta(i,j) = pi;
            else
                % Compute angle of intersection between circles i and j
                a = acos((R(i)^2 + D(i,j)^2 - R(j)^2) / (2 * R(i) * D(i,j)));
                b = acos((R(j)^2 + D(i,j)^2 - R(i)^2) / (2 * R(j) * D(i,j)));
                theta(i,j) = a + b;
            end
            theta(j,i) = theta(i,j);  % Symmetric
            E = [E; i, j];  % Add edge to list
        end
    end
end

% Compute coordinates of circle centers
for i = 1:n
    t = sum(theta(i,:));
    if t == 0
        % Circle i is isolated
        C(i,:) = [0, 0];
    else
        % Compute weighted average of neighbors' positions
        C(i,:) = sum(C .* (theta(i,:)' * ones(1,2)), 1) / t;
    end
end

end
