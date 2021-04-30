[magnitudeLeft, freqLeft, ...
    magnitudeRight, ~] = calculateFreqILDfromHRTF(0,0);

% Plot HRTF
subplot(2,2,1);
grid on;
hold on;
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Azimuth - 0 Degrees');

plot(freqLeft,magnitudeLeft(:,:)-magnitudeRight(:,:));
xticks([100 250 500 1000 2000 4000 8000 16000 20000])

legend('ILD','location','southwest');

[magnitudeLeft, freqLeft, ...
    magnitudeRight, ~] = calculateFreqILDfromHRTF(0,180);

% Plot HRTF
subplot(2,2,2);
grid on;
hold on;
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Azimuth - 180 Degrees');

plot(freqLeft,magnitudeLeft(:,:)-magnitudeRight(:,:));
xticks([100 250 500 1000 2000 4000 8000 16000 20000])

legend('ILD','location','southwest');

[magnitudeLeft, freqLeft, ...
    magnitudeRight, ~] = calculateFreqILDfromHRTF(0,270);

% Plot HRTF
subplot(2,2,3);
grid on;
hold on;
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Azimuth - -90 Degrees');

plot(freqLeft,magnitudeLeft(:,:)-magnitudeRight(:,:));
xticks([100 250 500 1000 2000 4000 8000 16000 20000])

legend('ILD','location','southwest');


[magnitudeLeft, freqLeft, ...
    magnitudeRight, freqRight] = calculateFreqILDfromHRTF(0,90);

% Plot HRTF
subplot(2,2,4);
grid on;
hold on;
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Azimuth - +90 Degrees');

plot(freqLeft,magnitudeLeft(:,:)-magnitudeRight(:,:));
xticks([100 250 500 1000 2000 4000 8000 16000 20000])

legend('ILD','location','southwest');

