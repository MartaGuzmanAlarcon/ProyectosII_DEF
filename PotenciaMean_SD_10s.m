% Media y desviacion potencia para ventanas de 10s

archivos = {'PotenciasOpenSignal_TopM_R1_2024-04-03.txt.csv', ...
            'PotenciasOpenSignal_TopM_R2_2024-04-09.txt.csv', ...
            'PotenciasOpenSignal_TopM_R3_2024-04-15.txt.csv', ...
            'PotenciasOpenSignal_TopM_R4_2024-04-22.txt.csv', ...
            'PotenciasOpenSignal_TopS_R1_2024-04-04.txt.csv', ...
            'PotenciasOpenSignal_TopS_R2_2024-04-12.txt.csv', ...
            'PotenciasOpenSignal_TopS_R3_2024-04-16.txt.csv', ...
            'PotenciasOpenSignal_TopS_R4_2024-04-23.txt.csv', ...
            'PotenciasOpenSignal_TopXS_R1_2024-04-05.txt.csv', ...
            'PotenciasOpenSignal_TopXS_R2_2024-04-11.txt.csv', ...
            'PotenciasOpenSignal_TopXS_R3_2024-04-18.txt.csv', ...
            'PotenciasOpenSignal_TopXS_R4_2024-04-29.txt.csv'};

% Creo matrices para almacenar los resultados
num_archivos = length(archivos);
medias = zeros(num_archivos, 1);
desviaciones = zeros(num_archivos, 1);

% Calcular la media y la desviación estándar de la cuarta columna de cada archivo
for i = 1:num_archivos
    data = readtable(archivos{i});
    % Asumiendo que queremos la cuarta columna, que sería data(:, 4)
    potencia_total_xyz = data{:, 4};
    medias(i) = mean(potencia_total_xyz);
    desviaciones(i) = std(potencia_total_xyz);
    
    % Imprimir resultados de cada archivo
    fprintf('Archivo: %s\n', archivos{i});
    fprintf('Media de la cuarta columna: %g\n', medias(i));
    fprintf('Desviación estándar de la cuarta columna: %g\n\n', desviaciones(i));
end

% Crear una tabla con los resultados
resultados = table(archivos', medias, desviaciones, ...
                   'VariableNames', {'Archivo', 'Media', 'DesviacionEstandar'});

% Escribir la tabla en un archivo CSV
writetable(resultados, 'Power_10s_resultados_medias_desviaciones.csv');