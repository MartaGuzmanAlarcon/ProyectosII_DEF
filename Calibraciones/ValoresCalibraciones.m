
%Calculate the max, and min 

% Leer los datos del archivo actual usando readmatrix
calibracionx = readmatrix('calibracion_x.txt'); 
calibraciony = readmatrix('calibracion_y.txt');
calibracionz = readmatrix('calibracion_z.txt');

% Extraer las columnas correspondientes a las posiciones x, y, z
posicion_x = calibracionx(:, 6);
posicion_y = calibraciony(:, 5);
posicion_z = calibracionz(:, 4);


 min_x = min(posicion_x);
 min_y = min(posicion_y);
 min_z = min(posicion_z);
 max_x = max(posicion_x);
 max_y = max(posicion_y);
 max_z = max(posicion_z);