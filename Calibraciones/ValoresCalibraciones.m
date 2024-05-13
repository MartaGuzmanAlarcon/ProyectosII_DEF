% Leer los datos del archivo actual usando readmatrix
calibracionx = readmatrix('calibracion_x.txt'); 
calibraciony = readmatrix('calibracion_y.txt');
calibracionz = readmatrix('calibracion_z.txt');

% Definir las columnas correspondientes a las posiciones en los archivos
columna_x = 6;
columna_y = 5;
columna_z = 4;

% Calcular máximos y mínimos para calibracionx
max_x_file1 = max(calibracionx(:, columna_x));
min_x_file1 = min(calibracionx(:, columna_x));
max_y_file1 = max(calibracionx(:, columna_y));
min_y_file1 = min(calibracionx(:, columna_y));
max_z_file1 = max(calibracionx(:, columna_z));
min_z_file1 = min(calibracionx(:, columna_z));

% Calcular máximos y mínimos para calibraciony
max_x_file2 = max(calibraciony(:, columna_x));
min_x_file2 = min(calibraciony(:, columna_x));
max_y_file2 = max(calibraciony(:, columna_y));
min_y_file2 = min(calibraciony(:, columna_y));
max_z_file2 = max(calibraciony(:, columna_z));
min_z_file2= min(calibraciony(:, columna_z));

% Calcular máximos y mínimos para calibracionz
max_x_file3 = max(calibracionz(:, columna_x));
min_x_file3 = min(calibracionz(:, columna_x));
max_y_file3 = max(calibracionz(:, columna_y));
min_y_file3 = min(calibracionz(:, columna_y));
max_z_file3 = max(calibracionz(:, columna_z));
min_z_file3 = min(calibracionz(:, columna_z));

% Calcular máximos y mínimos globales para cada posición
max_x_global = max([max_x_file1, max_x_file2, max_x_file3]);
min_x_global = min([min_x_file1, min_x_file2, min_x_file3]);
max_y_global = max([max_y_file1, max_y_file2, max_y_file3]);
min_y_global = min([min_y_file1, min_y_file2, min_y_file3]);
max_z_global = max([max_z_file1, max_z_file2, max_z_file3]);
min_z_global = min([min_z_file1, min_z_file2, min_z_file3]);