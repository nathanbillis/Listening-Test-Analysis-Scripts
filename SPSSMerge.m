directory = "/Users/nathan/Documents/MATLAB/Listening-Test-Analysis-Scripts/Results";
myfiles = dir(directory);
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';
csvfiles=filenames(endsWith(filenames,'.csv'));
csvfolders=filefolders(endsWith(filenames,'.csv'));
files=fullfile(csvfolders,csvfiles);
allResults = ["type" "difference" "angle" "subject"];


for fileIndex = 1:size(files)
    csvLocation = string(files(fileIndex));
    fileContent = loadCSV(csvLocation);
    data = extractEvaluationData(fileContent);
    results = calculatePositionDifferencev2(data);
    UID(fileIndex) = fileContent.UID;
    for rowIndex = 1:size(results.generic.difference)
        dataRow1 = [0 results.generic.difference(rowIndex) results.generic.positions(rowIndex) fileIndex];
        dataRow2 = [1 results.calibrated.difference(rowIndex) results.calibrated.positions(rowIndex) fileIndex];
        data = vertcat(dataRow1,dataRow2);
        allResults = vertcat(allResults,data);
    end
end