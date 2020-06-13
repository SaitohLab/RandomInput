% 2019/10/17
% File_name : MonteCarloInput.m

% Display the cube (1Å~1Å~1) that is the existence range of the solution
vert = [0 0 0;1 0 0;1 1 0;0 1 0;0 0 1;1 0 1;1 1 1;0 1 1];
fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
patch('Vertices',vert,'Faces',fac,'FaceVertexCData',(1:6)','FaceColor','flat','FaceAlpha',0.5)
view(3)
axis vis3d
hold on

% Plot solution space.
C = 0.60;  % Constant
N = 600;   % Plot Number
x_min = 0; % Minimum of Inequality
x_max = 1; % Maximum of Inequality
x = zeros(N, 3);

for i = 1 : round(N/3)
    x(i, 1) = rand();
    x(i, 2) = rand();
    x(i, 3) = C - x(i, 1) - x(i, 2); % x1 + x2 + x3 = C (= Constant)
end

for i = round(N/3)+1 : round(2*N/3)
    x(i, 3) = rand();
    x(i, 2) = rand();
    x(i, 1) = C - x(i, 3) - x(i, 2); % x1 + x2 + x3 = C (= Constant)
end

for i = round(2*N/3)+1 : N
    x(i, 3) = rand();
    x(i, 1) = rand();
    x(i, 2) = C - x(i, 3) - x(i, 1); % x1 + x2 + x3 = C (= Constant)
end

cnt = 0;
for i = 1:N
    if (x_min < x(i, 1) && x(i, 1) < x_max) && (x_min < x(i, 2) && x(i, 2) < x_max) && (x_min < x(i, 3) && x(i, 3) < x_max)
        % If inequality (0 < x1, x2, x3 < 1) are satisfied, plot red cercle.
        plot3(x(i, 1), x(i, 2), x(i, 3),'ro')
        cnt = cnt + 1;
    else
        % If inequality (0 < x1, x2, x3 < 1) are Not satisfied, plot blue cross.
        plot3(x(i, 1), x(i, 2), x(i, 3),'bx')
    end
end

hold off

% The Inputs that satisfy the inequality constraints are stored in "x_sol".
% In this case, let the inequality constraint be 0 < x < 1.
% Generally, x_min < x < x_max.
x_sol = zeros(cnt, 3);
k = 0;
for i = 1:N
    if (x_min < x(i, 1) && x(i, 1) < x_max) && (x_min < x(i, 2) && x(i, 2) < x_max) && (x_min < x(i, 3) && x(i, 3) < x_max)
        for j = 1:3
            k = k + 1;
            x_sol(k, j) =  x(i, j);
        end
    end
end