SOFAstart();

hrtf = SOFAload('D1_44K_16bit_256tap_FIR_SOFA.sofa');
hrtfExpanded = SOFAexpand(hrtf);

ILD = zeros(1,360);

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
            ILD(round(pos2+1)) = 10*log(HRTF_L/HRTF_R);
        end
    end

azimiuth = -180:179;
plot(azimiuth,ILD ,'r', 'DisplayName',"Generic KU100");
hold on;

hrtf = SOFAload('D1_ILD_Scaled.sofa');
% hrtf = SOFAload('D2_44K_16bit_256tap_FIR_SOFA.sofa');

hrtfExpanded = SOFAexpand(hrtf);

ILD = zeros(1,360);

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
            ILD(round(pos2+1)) = 10*log(HRTF_L/HRTF_R);
        end
    end

azimiuth = -180:179;
plot(azimiuth,ILD ,'b','DisplayName',"Scaled HRTF");

hrtf = SOFAload('H3_44K_16bit_256tap_FIR_SOFA.sofa');
hrtfExpanded = SOFAexpand(hrtf);

ILD2 = nan(1,360);
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
            ILD2(round(pos2+1)) = 10*log((HRTF_L)/HRTF_R);
        end
 end
 
 % add line 

ILDTest = interp1(0:359,ILD2,0:359,'spline');
azimiuth = -180:179;
plot(azimiuth,ILDTest,'green', 'DisplayName',"H3 Human HRTF");

% hrtf = SOFAload('H9_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtfExpanded = SOFAexpand(hrtf);
% 
% ILD2 = nan(1,360);
% found = 0;
% 
% posIndex2 = hrtfExpanded.SourcePosition(:,2,:);
% posIndex1 = hrtfExpanded.SourcePosition(:,1,:);
% posIndex = 1;
% 
%  while posIndex < size(posIndex1,1)
%         posIndex = posIndex + 1;
%         posPos = posIndex2(posIndex);
%         pos2 = posIndex1(posIndex);
%         if posPos == 0
%             HRTF_R = norm(squeeze(hrtfExpanded.Data.IR(posIndex,1,:)));
%             HRTF_L = norm(squeeze(hrtfExpanded.Data.IR(posIndex,2,:)));
%             ILD2(round(pos2+1)) = 10*log((HRTF_L)/HRTF_R);
%         end
%  end
%  
%  % add line 
% 
% ILDTest = interp1(0:359,ILD2,0:359,'spline');
% azimiuth = -180:179;
% plot(azimiuth,ILDTest,'black');
% 
% for data = 1:360
%     ILDno1 = ILD(data);
%     ILDno2 = ILD2(data);
%     ILD3(data) = ILDno2 - ILDno1;
% end
% 
% ILD3Inter = interp1(0:359,ILD3,0:359,'spline');
% 
% plot(azimiuth,ILD3Inter);

plot([180 90 0 -90 -180], [0 20 0 -20 0], '--', "DisplayName",'-20dB - +20dB Ref');
plot([180 -180], [0 0], '-', 'DisplayName',"");
hold off;
grid on;
title('HRTF ILD Comparisons');
ylabel('ILD (dB)');

legend('Location','southeast');
