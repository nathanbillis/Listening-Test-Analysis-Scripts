SOFAstart();

hrtf = SOFAload('D1_44K_16bit_256tap_FIR_SOFA.sofa');
hrtfExpanded = SOFAexpand(hrtf);

ILD = zeros(1,360);

posIndex2 = hrtfExpanded.SourcePosition(:,2,:);
posIndex1 = hrtfExpanded.SourcePosition(:,1,:);  

posIndex = 1;

    while posIndex < size(posIndex1,1)
        posIndex = posIndex + 1;
        elevation = posIndex2(posIndex);
        azimuth = posIndex1(posIndex);
        if elevation == 0
            HRTF_R = norm(squeeze(hrtfExpanded.Data.IR(posIndex,1,:)));
            HRTF_L = norm(squeeze(hrtfExpanded.Data.IR(posIndex,2,:)));
            ILD(round(azimuth+1)) = 10*log(HRTF_L/HRTF_R);
        end
    end

azimiuth = 75:1:110;
plot(azimiuth,ILD(75:1:110),'r', 'DisplayName',"Generic KU100");
grid on;
title('HRTF ILD between 75 - 105 degrees');
ylabel('ILD (dB)');

legend('Location','southeast');
