function [data] = loadCSV(fileLocation)
%loadCSV Load results data into structure
%   Loads the results CSV file into a handy data structure
data = struct;
data.UID = extractBefore(fileLocation,'_');
data.fileLocation = fileLocation;

calibrationData = readmatrix(fileLocation, 'Range', [4 2 9 2]);
data.leftAverage = calibrationData(5);
data.rightAverage = calibrationData(6);
data.leftCalibration(1) = calibrationData(2);
data.leftCalibration(2) = calibrationData(4);

data.rightCalibration(1) = calibrationData(1);
data.rightCalibration(2) = calibrationData(3);

fileData = readmatrix(fileLocation);
data.training = fileData(1:5,:);
data.evaluation = fileData(7:end,:);
end

