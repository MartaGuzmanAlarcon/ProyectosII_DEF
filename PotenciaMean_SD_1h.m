
% Media y desviacion potencia para ventanas de 1h

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

% Preallocar celdas para almacenar los resultados
medias_por_archivo = cell(length(archivos), 1);
desviaciones_por_archivo = cell(length(archivos), 1);

% 1 hora = 3600 segundos -> 3600 / 10 = 360 muestras por hora
muestras_por_hora = 360;

% Calcular la media y la desviación estándar de la cuarta columna (potencia_total_xyz) de cada archivo para ventanas de 1 hora
for i = 1:length(archivos)
    data = readtable(archivos{i});
    potencia_total_xyz = data{:, 4};

    % Dividir los datos en bloques de 1 hora -> "muestreo"
    num_muestras = length(potencia_total_xyz);
    num_bloques = floor(num_muestras / muestras_por_hora);

    medias_bloques = zeros(num_bloques, 1);
    desviaciones_bloques = zeros(num_bloques, 1);

    for j = 1:num_bloques
        inicio = (j-1) * muestras_por_hora + 1;
        fin = j * muestras_por_hora;
        bloque = potencia_total_xyz(inicio:fin);
        medias_bloques(j) = mean(bloque);
        desviaciones_bloques(j) = std(bloque);
    end

    % Almacenar los resultados de cada ventana de 1 hora
    medias_por_archivo{i} = medias_bloques;
    desviaciones_por_archivo{i} = desviaciones_bloques;
    
    % Imprimir resultados de cada archivo
    fprintf('Archivo: %s\n', archivos{i});
    fprintf('Medias de la cuarta columna (ventanas de 1 hora): %s\n', num2str(medias_bloques'));
    fprintf('Desviaciones estándar de la cuarta columna (ventanas de 1 hora): %s\n\n', num2str(desviaciones_bloques'));
end

% Crear una tabla con los resultados
resultados = table();
for i = 1:length(archivos)
    archivo = repmat(archivos(i), numel(medias_por_archivo{i}), 1);
    medias = medias_por_archivo{i};
    desviaciones = desviaciones_por_archivo{i};
    temp_tabla = table(archivo, medias, desviaciones, 'VariableNames', {'Archivo', 'Media', 'DesviacionEstandar'});
    resultados = [resultados; temp_tabla];
end

% Escribir la tabla en un archivo CSV
writetable(resultados, 'Power_1h_resultados_medias_desviaciones.csv');
