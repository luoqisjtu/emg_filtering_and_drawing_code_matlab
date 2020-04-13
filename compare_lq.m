
data1=load('compare_data_lq.txt');
fs=100;
pre=data1(500:1300,1);
raw=data1(500:1300,2);
but=data1(500:1300,3);
bay=data1(500:1300,4);
l=length(raw);
figure(1);
subplot(411);plot(0:1/fs:(l-1)/fs,(pre-min(pre))/(max(pre)-min(pre)),'k');xlim([0 8]);title('Pressure');ylim([0 4]);set(gca,'YTickLabel',{'0','3.0','4.5'},'LineWidth',1.5);xlabel('Time(sec)');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
subplot(412);plot(0:1/fs:(l-1)/fs,(raw-min(raw))/(max(raw)-min(raw)),'k');xlim([0 8]);title('Raw EMG');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
subplot(413);plot(0:1/fs:(l-1)/fs,(but-min(but))/(max(but)-min(but)),'k');xlim([0 8]);title('Butterworth');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
subplot(414);plot(0:1/fs:(l-1)/fs,(bay-min(bay))/(max(bay)-min(bay)),'k');xlim([0 8]);title('Bayesian');ylim([0 1.05]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);

