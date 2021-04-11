function [data] = extractEvaluationData(decodedCSV)
%extractEvaluationData Extracts data from the CSV structure to provide a
%known order to the data.

evaluationData = decodedCSV.evaluation;
dataSize = size(evaluationData);
genericData = nan(dataSize);
calibratedData = nan(dataSize);
genericPos = 1;
calibratedPos = 1;

for rowIndex = 1:size(evaluationData)
    row = evaluationData(rowIndex,:);
    if row(4) == 1
        calibratedData(calibratedPos,:) = row;
        calibratedPos = calibratedPos + 1;
    elseif row(4) == 0
        genericData(genericPos,:) = row;
        genericPos = genericPos + 1;
    end  
end

data.generic = genericData;
data.calibrated = calibratedData;
end

