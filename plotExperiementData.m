SOFAstart();

directory = "/Users/nathan/Documents/MATLAB/Listening-Test-Analysis-Scripts/Results";
allResults = combineAllResults(90,directory);

genericMedian = median(abs(allResults.generic.difference));
calibratedMedian = median(abs(allResults.calibrated.difference));

figure('Name','Degree diffence from actual angle');
title('Degree diffence from actual angle');
subplot(2,1,1)
boxplot(allResults.generic.difference, allResults.generic.positions);
ylabel('Degree difference');
xlabel('Evaluation Angles');
title('Generic');

subplot(2,1,2)
boxplot(allResults.calibrated.difference, allResults.calibrated.positions);
ylabel('Degree difference');
xlabel('Evaluation Angles');
title('Personalised');

disp(genericMedian);
disp(calibratedMedian);
