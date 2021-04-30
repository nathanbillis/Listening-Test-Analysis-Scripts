function [magnitudeLeft,freqLeft,magnitudeRight,freqRight] = calculateFreqILDfromHRTF(elevation,azimuth)
%CALCULATEFREQILDFROMHRTF Summary of this function goes here
%   Detailed explanation goes here
SOFAstart();

% load HRTF Files
hrtf = SOFAload('SADIIE/D1_44K_16bit_256tap_FIR_SOFA.sofa');
hrtfExpanded = SOFAexpand(hrtf);
fs = hrtf.Data.SamplingRate;

posLeft = hrtfExpanded.SourcePosition(:,2,:);
posRight = hrtfExpanded.SourcePosition(:,1,:);

posIndex = 1;

while posIndex < size(posRight,1)
    posIndex = posIndex + 1;
    posElevation = posLeft(posIndex);
    posAzimuth = posRight(posIndex);
    if posElevation == elevation && posAzimuth == azimuth
        leftChannel = squeeze(hrtfExpanded.Data.IR(posIndex,1,:));
        rightChannel = squeeze(hrtfExpanded.Data.IR(posIndex,2,:));
        position = posIndex;
    end
end

x = 0.01:0.01:(size(leftChannel)/100);

% Calculate HRTF

noisefloor=-50;
magnitudeLeft=(20*log10(abs(fft(leftChannel')')));
magnitudeLeft(magnitudeLeft<noisefloor)=noisefloor;
freqLeft = 0:fs/size(leftChannel,1):(size(magnitudeLeft,1)-1)*fs/size(leftChannel,1);
freqLeft(freqLeft>20000) = nan;


magnitudeRight=(20*log10(abs(fft(rightChannel')')));
magnitudeRight(magnitudeRight<noisefloor)=noisefloor;
freqRight = 0:fs/size(rightChannel,1):(size(magnitudeRight,1)-1)*fs/size(rightChannel,1);
freqRight(freqRight>20000) = nan;
end

