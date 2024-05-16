% Frecuencia de muestreo original
frecuencia_original = 1000;  % Hz

% Número de muestras por ventana de 10 segundos
muestras_por_ventana = round(frecuencia_original * 10); % 10000 samples

% Nombres de los archivos de prueba: 
file1 = 'TopM_R1_2024-04-03.txt';
file2 = 'TopM_R2_2024-04-09.txt';
file3 = 'TopM_R3_2024-04-15.txt';
file4 = 'TopM_R4_2024-04-22.txt';

file5 = 'TopS_R1_2024-04-04.txt';
file6 = 'TopS_R2_2024-04-12.txt';
file7 = 'TopS_R3_2024-04-16.txt';
file8 = 'TopS_R4_2024-04-23.txt';

file9  = 'TopXS_R1_2024-04-05.txt';
file10 = 'TopXS_R2_2024-04-11.txt';
file11 = 'TopXS_R3__2024-04-18.txt';
file12 = 'TopXS_R4_2024-04-29.txt';

files_pruebaCortas_OpenSignal = {file1, file2, file3, file4, file5, file6, file7, file8, file9, file10, file11, file12};

% Loop sobre cada archivo
for file_index = 1:numel(files_pruebaCortas_OpenSignal)
    file_name = files_pruebaCortas_OpenSignal{file_index};
    
    % Leer los datos del archivo actual usando readmatrix
    data = readmatrix(file_name);  % Suponiendo que los datos están en formato adecuado para la carga
    
    % Extraer las columnas correspondientes a las posiciones x, y, z
    posicion_x = data(:, 6);
    posicion_y = data(:, 5);
    posicion_z = data(:, 4);

    % CALIBRACIONES -> caluladas en el archivo ValoresCalibraciones
    min_x = 26568;
    min_y = 32036;
    min_z = 32444;

    max_x = 33580;
    max_y = 38632;
    max_z = 35940;

    aceleracion_x =  2*(posicion_x-min_x)/(max_x-min_x) -1;
    aceleracion_y =  2*(posicion_y-min_y)/(max_y-min_y) -1;
    aceleracion_z =  2*(posicion_z-min_z)/(max_z-min_z) -1;

    % Calcular las velocidades a partir de las posiciones (primera derivada)
    %velocidad_x = diff(posicion_x);
    %velocidad_y = diff(posicion_y);
    %velocidad_z = diff(posicion_z);

    % Asumir un intervalo de tiempo constante (s)
    %intervalo_tiempo = mean(diff(data(:, 1)));  

    % Calcular las aceleraciones a partir de las velocidades (segunda derivada)
    %aceleracion_x = diff(velocidad_x) / intervalo_tiempo;
    %aceleracion_y = diff(velocidad_y) / intervalo_tiempo;
    %aceleracion_z = diff(velocidad_z) / intervalo_tiempo;

    % Inicializar variables para el filtro paso bajo
    g_x = 0;
    g_y = 0;
    g_z = 0;

    % Aplicar el filtro paso bajo a las lecturas del acelerómetro
    for i = 1:length(aceleracion_x)
        % Aplicar filtro paso bajo a la componente x
        g_x = 0.9 * g_x + 0.1 * aceleracion_x(i);
        aceleracion_x(i) = aceleracion_x(i) - g_x;

        % Aplicar filtro paso bajo a la componente y
        g_y = 0.9 * g_y + 0.1 * aceleracion_y(i);
        aceleracion_y(i) = aceleracion_y(i) - g_y;

        % Aplicar filtro paso bajo a la componente z
        g_z = 0.9 * g_z + 0.1 * aceleracion_z(i);
        aceleracion_z(i) = aceleracion_z(i) - g_z;
    end

    % Inicializar matrices para almacenar los resultados
    resultados = zeros(floor(length(aceleracion_x)/muestras_por_ventana), 4);

    % Calcular la potencia total para cada ventana de 10 segundos
    indice_resultados = 1;
    for i = 1 : muestras_por_ventana : length(aceleracion_x)
        ventana_x = aceleracion_x(i : min(i + muestras_por_ventana - 1, length(aceleracion_x)));
        ventana_y = aceleracion_y(i : min(i + muestras_por_ventana - 1, length(aceleracion_y)));
        ventana_z = aceleracion_z(i : min(i + muestras_por_ventana - 1, length(aceleracion_z)));

        potencia_x = mean(ventana_x.^2);
        potencia_y = mean(ventana_y.^2);
        potencia_z = mean(ventana_z.^2);

        potencia_total_xyz= potencia_x + potencia_y + potencia_z;

        % Guardar resultados en la matriz 
        resultados(indice_resultados, :) = [potencia_x, potencia_y, potencia_z, potencia_total_xyz];

        % Incrementar el índice de resultados
        indice_resultados = indice_resultados + 1;
    end

    % Nombre del archivo CSV de salida
    nombre_archivo = ['PotenciasOpenSignal_', file_name, '.csv'];

    % Crear una tabla con nombres de columnas
    columnas = {'potencia_x', 'potencia_y', 'potencia_z', 'potencia_total_xyz'};
    tabla_resultados = array2table(resultados, 'VariableNames', columnas);

    % Escribir en el archivo CSV
    writetable(tabla_resultados, nombre_archivo);

    % Agregar el nombre del archivo generado al array + create file, para usar en el calculo msqi
    potencias_archivos_generados{file_index} = nombre_archivo;

end

file_list = cell2table(potencias_archivos_generados', 'VariableNames', {'NombreArchivo'});
csv_filename = 'potencias_NombresArchivosOpenSignal.csv';
writetable(file_list, csv_filename);


  

