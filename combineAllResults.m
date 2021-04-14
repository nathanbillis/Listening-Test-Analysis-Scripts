function [allResults] = combineAllResults(toleranceAngle, directory)
%combineAllResults combines all the csv files

myfiles = dir(directory);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
csvfiles=filenames(endsWith(filenames,'.csv'));
csvfolders=filefolders(endsWith(filenames,'.csv'));
files=fullfile(csvfolders,csvfiles);

allResults = struct;
allResults.files = files;
allResults.generic = struct;
allResults.generic.difference = [];
allResults.generic.positions = [];

allResults.calibrated = struct;
allResults.calibrated.difference = [];
allResults.calibrated.positions = [];

allResults.leftAverage = [];
allResults.rightAverage = [];


allResults.calibrated.median = [];
allResults.generic.median = [];


for fileIndex = 1:size(files)
    csvLocation = string(files(fileIndex));
    fileContent = loadCSV(csvLocation);
    data = extractEvaluationData(fileContent);
    results = calculatePositionDifference(data); 
    if (results.calibrated.median <= toleranceAngle || results.generic.median <= toleranceAngle)
        allResults.generic.difference = vertcat(allResults.generic.difference,results.generic.difference);
        allResults.generic.positions = vertcat(allResults.generic.positions,results.generic.positions);

        allResults.calibrated.difference = vertcat(allResults.calibrated.difference,results.calibrated.difference);
        allResults.calibrated.positions = vertcat(allResults.calibrated.positions,results.calibrated.positions);

        allResults.leftAverage = vertcat(allResults.leftAverage,fileContent.leftAverage);
        allResults.rightAverage = vertcat(allResults.rightAverage,fileContent.rightAverage); 

        allResults.calibrated.median = vertcat(allResults.calibrated.median,results.calibrated.median);
        allResults.generic.median = vertcat(allResults.generic.median,results.generic.median);
    end
end

end

