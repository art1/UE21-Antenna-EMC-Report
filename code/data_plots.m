close all; clc; clear all;

D = csvread('../data/directivity.csv',1)
% remove unneccessary zeroes
D(:,3:7) = [];

% move by 180 degree for directivity plot
for k=1: length(D)
   D(k,1) = D(k,1) - 180;
   if D(k,1) < -180
       D(k,1) = D(k,1) + 360;
   end
end

% move data to have correct dirction in plot
% circshift not workign for reasosn...
tmp = D(ceil(length(D)/2)+1:length(D),2);
tmp2 = D(1:ceil(length(D)/2),2);
D(:,2) = [tmp' tmp2'];

figure
dirplot(D(:,1),D(:,2),'r')
set( findobj(gca,'type','line'), 'LineWidth', 3);
title('Radiation Pattern of Hyperlog 7025');
saveas(gcf,'../images/hyperlog.png')


%% distance vs dB plot of other antenna
E = csvread('../data/distance_meas.csv',1)
% remove unneccessary zeroes
E(:,3:7) = [];
figure, plot(E(:,1),E(:,2),'+')
h = lsline;
set(h,'color','r')
ylabel('Received Power in dB');
xlabel('Distance in m');
saveas(gcf,'../images/omnidir.png')
