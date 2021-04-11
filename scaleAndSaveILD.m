% Estimated ILD from measurement TODO read from matrix
ILDLeftEstimated = -23.41113106;
ILDRightEstimated = -24.54219031;

SOFAstart();

% Load in Generic KU100 HRTF
hrtf = SOFAload('D1_44K_16bit_256tap_FIR_SOFA.sofa');
hrtfExpanded = SOFAexpand(hrtf);

% Create Array for HRTF along 0 Elevation
ILD = zeros(1,360);

% Calculate ILD for all the positions
leftChannels = hrtfExpanded.SourcePosition(:,2,:);
rightChannels = hrtfExpanded.SourcePosition(:,1,:);

posIndex = 1;

while posIndex < size(rightChannels,1)
    posIndex = posIndex + 1;
    elevationPos = leftChannels(posIndex);
    azimuthPos = rightChannels(posIndex);
    if elevationPos == 0
        HRTF_R = norm(squeeze(hrtfExpanded.Data.IR(posIndex,1,:)));
        HRTF_L = norm(squeeze(hrtfExpanded.Data.IR(posIndex,2,:)));
        ILD(round(azimuthPos+1)) = 10*log(HRTF_L/HRTF_R);
    end
end

ILDLeftGeneric = ILD(90);
ILDRightGeneric = -ILD(270);

% Calculate Scaling Factor
scalingFactorLeft = ILDLeftEstimated / ILDLeftGeneric;
scalingFactorRight = ILDRightEstimated / ILDRightGeneric;

% Scale and Resave to SOFA for efficency
hrtfScaled = hrtf;

% 1 - 180 = Left Ear
% 181 - 360 = Right Ear

% Create Array for HRTF along 0 Elevation
ILDCalculated = zeros(1,360);

% Calculate ILD for all the positions
leftChannels = hrtfExpanded.SourcePosition(:,2,:);
rightChannels = hrtfExpanded.SourcePosition(:,1,:);

posIndex = 1;

while posIndex < size(rightChannels,1)
    posIndex = posIndex + 1;
    elevationPos = leftChannels(posIndex);
    azimuthPos = rightChannels(posIndex);
    if elevationPos == 0
        if azimuthPos <= 180
            leftData = hrtfExpanded.Data.IR(posIndex,1,:).^scalingFactorLeft;
            rightData = hrtfExpanded.Data.IR(posIndex,2,:).^scalingFactorLeft;
            hrtfScaled.Data.IR(posIndex,1,:) = real(leftData);
            hrtfScaled.Data.IR(posIndex,2,:) = real(rightData);
            HRTF_RTest = norm(squeeze(hrtfScaled.Data.IR(posIndex,1,:)));
            HRTF_LTest = norm(squeeze(hrtfScaled.Data.IR(posIndex,2,:)));
        elseif azimuthPos > 180
            leftData = hrtfExpanded.Data.IR(posIndex,1,:).^scalingFactorRight;
            rightData = hrtfExpanded.Data.IR(posIndex,2,:).^scalingFactorRight;
            hrtfScaled.Data.IR(posIndex,1,:) = real(leftData);
            hrtfScaled.Data.IR(posIndex,2,:) = real(rightData);
            HRTF_RTest = norm(squeeze(hrtfScaled.Data.IR(posIndex,1,:)));
            HRTF_LTest = norm(squeeze(hrtfScaled.Data.IR(posIndex,2,:)));
        end
        ILDCalculated(round(azimuthPos+1)) = 10*log(HRTF_LTest/HRTF_RTest);
    end
end

ILDLeftCalculated = ILDCalculated(90);
ILDRightCalculated = -ILDCalculated(270);

hrtfScaled.GLOBAL_Title = 'ILD Scaled D1 KU100 subject';
hrtfScaled.GLOBAL_ListenerShortName = 'D1-Scaled';
hrtfScaled.GLOBAL_Comment = 'Only positions along 0 elevation are scaled. 8802 source positions. KU100 subject. Measurement utlized Genelec 8010 Loudspeakers and 24s overlapped swept sine technique. Reciever microphones were KU100 built in mics via RME Fireface 400 Preamps. Filters were low frequency extended, diffuse field equalized and windowed. (approx.) Linear phase HRIRs.';

SOFAsave('D1_ILD_Scaled.sofa',hrtfScaled,0);

