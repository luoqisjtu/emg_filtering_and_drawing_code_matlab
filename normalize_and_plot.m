%% Velocity regulation EMG

fname_read = 'emg_data_vc.csv';       
emg_data = csvread(fname_read,1,0);
fs=100;

rawEMG_v1=emg_data(1250:1950,2);
rawEMG_v2=emg_data(350:1050,3);
rawEMG_v3=emg_data(250:950,4);

% rawEMG_v1=emg_data(1400:2600,2);
% rawEMG_v2=emg_data(1400:2400,4);
% rawEMG_v3=emg_data(1500:1800,6);
% 
% bayesEMG_v1=emg_data(1400:2600,3);
% bayesEMG_v2=emg_data(1400:2400,5);
% bayesEMG_v3=emg_data(1500:1800,7);

l1=length(rawEMG_v1);
l2=length(rawEMG_v2);
l3=length(rawEMG_v3);


figure(1);
subplot(3,1,1);plot(0:1/fs:(l1-1)/fs,(rawEMG_v1-min(rawEMG_v1))/(max(rawEMG_v1)-min(rawEMG_v1)),'k');title('rawEMG_v1');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
box off;
subplot(3,1,2);plot(0:1/fs:(l2-1)/fs,(rawEMG_v2-min(rawEMG_v2))/(max(rawEMG_v2)-min(rawEMG_v2)),'k');title('rawEMG_v2');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
box off;
subplot(3,1,3);plot(0:1/fs:(l3-1)/fs,(rawEMG_v3-min(rawEMG_v3))/(max(rawEMG_v3)-min(rawEMG_v3)),'k');title('rawEMG_v3');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
box off;

% subplot(3,2,2);plot(0:1/fs:(l1-1)/fs,1*(bayesEMG_v1-min(bayesEMG_v1))/(max(bayesEMG_v1)-min(bayesEMG_v1)),'k');title('BayesEMG_v1');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;
% subplot(3,2,4);plot(0:1/fs:(l2-1)/fs,(bayesEMG_v2-min(bayesEMG_v2))/(max(bayesEMG_v2)-min(bayesEMG_v2)),'k');title('BayesEMG_v2');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;
% subplot(3,2,6);plot(0:1/fs:(l3-1)/fs,(bayesEMG_v3-min(bayesEMG_v3))/(max(bayesEMG_v3)-min(bayesEMG_v3)),'k');title('BayesEMG_v3');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;




% subplot(311);plot(0:1/fs:(l1-1)/fs,1*(rawEMG_v1-min(rawEMG_v1))/(max(rawEMG_v1)-min(rawEMG_v1)),'k');xlim([0 20]);title('rawEMG_v1');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% subplot(312);plot(0:1/fs:(l2-1)/fs,(rawEMG_v2-min(rawEMG_v2))/(max(rawEMG_v2)-min(rawEMG_v2)),'k');xlim([0 20]);title('rawEMG_v2');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% subplot(313);plot(0:1/fs:(l3-1)/fs,(rawEMG_v3-min(rawEMG_v3))/(max(rawEMG_v3)-min(rawEMG_v3)),'k');xlim([0 20]);title('rawEMG_v3');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);

