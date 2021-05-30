
polarAxis = polaraxes();
polarAxis.Units = 'pixels';

evaluationAngles = [0 10 20 30 45 60 90 100 110 120 130 140 150 160 170 ...
    -10 -20 -30 -45 -60 -90 -100 -110 -120 -130 -140 -150 -160 -170];
% Set plotting parameters
polarAxis.RLim = [0 2]; % set up plot limits
polarAxis.RTickLabel = {};
polarAxis.ThetaZeroLocation = 'top';
polarAxis.ThetaTickLabel = {'0', '-30', '-60', '-90', ...
    '-120', '-150', [char(177) '180'], '150', '120', '90', ...
    '60', '30'};
hold on;
% Plot x on polar plot - input is in degrees and needs to be
% negated and converted to radians to plot correctly
for position = 1:size(evaluationAngles,2)
    value = evaluationAngles(position);
    polarplot(polarAxis, deg2rad(-value), 1.5, 'xr', ...
        'MarkerSize', 15, 'LineWidth', 3 );
end

