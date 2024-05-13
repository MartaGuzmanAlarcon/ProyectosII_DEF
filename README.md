DEFAceleracionOpenSignal:
- Calculates the power for each window of 10s.
- Creates a ‘PotenciasOpenSignal_filename.csv’ per recording. This file contains the power in x,y,z and the total power of xyz. 
- Finally, creates a file with the names of all ‘potencias_NombresArchivosOpenSignal.csv’ that have been generated. (This file will be used in the correlation code)

mSQI_OpenSignal:
- Calculates the mSQI for each recording.
- Creates a ‘mSQI_OpenSignal_filename.csv’ per recording. This file contains the values fro the geometricMean_vector. 
- Finally, creates a file with the names of all ‘mSQI_NombresArchivos_OpenSignal.csv’ that have been generated. (This file will be used in the correlation code)

OpenSignal_correlation_powerANDmSQI:
- Calculates the correlation between the power and the geometricMean_vector.
- Creates a file to save the correlations.

ValoresCalibraciones:
- Calculates first the max and min of x,y,z for each calibration file.
- Calculates the max and min of those x,y,x that have been calculated ("global max and global min").
