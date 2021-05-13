function [results] = calculatePositionDifferencev2(data)
%calculatePositionDifference gets the position difference from the data

genericDiff = nan(size(data.generic));
genericPos = nan(size(data.generic));
calibratedDiff = nan(size(data.calibrated));
calibratedPos = nan(size(data.generic));

for rowIndex = 1:size(data.generic)
    difference = (data.generic(rowIndex,2)-data.generic(rowIndex,3));
    if difference > 180
        difference = difference - 360;
    elseif difference < -180
        difference = difference + 360;
    end
    genericDiff(rowIndex) = difference;
    genericPos(rowIndex) = data.generic(rowIndex,3);
end

for rowIndex = 1:size(data.calibrated)
    difference = (data.calibrated(rowIndex,2)-data.calibrated(rowIndex,3));
    
    if difference > 180
        difference = difference - 360;
    elseif difference < -180
        difference = difference + 360;
    end
    
    calibratedDiff(rowIndex) = difference;
    calibratedPos(rowIndex) = data.calibrated(rowIndex,3);
end

% Add caluclated data to struct
results.calibrated.difference = calibratedDiff(~isnan(calibratedDiff(:,1)));
results.generic.difference = genericDiff(~isnan(genericDiff(:,1)));

results.calibrated.positions = calibratedPos(~isnan(calibratedPos(:,1)));
results.generic.positions = genericPos(~isnan(genericPos(:,1)));

results.generic.median = median(abs(results.calibrated.difference));
results.calibrated.median = median(abs(results.generic.difference));
end

