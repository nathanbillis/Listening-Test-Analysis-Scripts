% Find all SADIE SOFA Files
SOFAstart();

directory = "/Users/nathan/Documents/MATLAB/Listening-Test-Analysis-Scripts/SADIIE";
myfiles = dir(directory);
filenames={myfiles(:).name}';
fileFolders={myfiles(:).folder}';
sofaFiles=filenames(endsWith(filenames,'.sofa'));
sofaFolders=fileFolders(endsWith(filenames,'.sofa'));
files=fullfile(sofaFolders,sofaFiles);

yline(0,'--')
hold on;
plot([180 90 0 -90 -180], [0 20 0 -20 0], '--');
legend('X Axis','20dB reference','Location','southeast','NumColumns',2)

grid on;
title('HRTF ILD Comparisons');
ylabel('ILD (dB)');

for index = 1:size(files)
    file = char(files(index));
    fileName = char(filenames(index+2));
    id = extractBefore(fileName,'_');
    hrtf = SOFAload(file);
    hrtfExpanded = SOFAexpand(hrtf);

    ILD = nan(1,360);
    found = 0;

    posIndex2 = hrtfExpanded.SourcePosition(:,2,:);
    posIndex1 = hrtfExpanded.SourcePosition(:,1,:);
    posIndex = 1;

     while posIndex < size(posIndex1,1)
            posIndex = posIndex + 1;
            posPos = posIndex2(posIndex);
            pos2 = posIndex1(posIndex);
            if posPos == 0
                HRTF_R = norm(squeeze(hrtfExpanded.Data.IR(posIndex,1,:)));
                HRTF_L = norm(squeeze(hrtfExpanded.Data.IR(posIndex,2,:)));
                ILD(round(pos2+1)) = 10*log((HRTF_L)/HRTF_R);
            end
     end
     
    interILD = interp1(0:359,ILD,0:359,'spline');
    azimiuth = -180:179;
    name = sprintf('%s Head', id);
    plot(azimiuth,interILD,'DisplayName',name);
end

hold off;
