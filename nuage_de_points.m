% === Code simple pour ajuster un plan par moindres carrés ===
clear; clc; close all;

% 1. Importer les données (fichier : nuage_de_points.txt)

data = readtable('nuage_de_points.txt', 'Delimiter', '\t', 'ReadVariableNames', true, 'TextType','string');
%% pour remplacer les , par des . 
for col = 1:width(data)
    strCol = string(data{:,col});
    strCol = strrep(strCol, ',', '.');
    data{:,col} = str2double(strCol);
end

x = double(data.X);
y = double(data.Y);
z = double(data.Z);


% 2. Calcul du plan des moindres carrés : z = a*x + b*y + c
A = [x y ones(size(data))];
coef = A \ z;   % résolution par moindres carrés
a = coef(1);
b = coef(2);
c = coef(3);
% 3. Affichage du résultat
fprintf('Équation du plan : z = %.4f*x + %.4f*y + %.4f\n', a, b, c);

% 4. Tracé du nuage de points et du plan
[X, Y] = meshgrid(linspace(min(x), max(x), 20), linspace(min(y), max(y), 20));
Z = a*X + b*Y + c;

figure;
scatter3(x, y, z, 'filled'); hold on;
surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Nuage de points et plan des moindres carrés');
grid on; axis equal;
