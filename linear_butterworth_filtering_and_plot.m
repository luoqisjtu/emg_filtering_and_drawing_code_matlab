%% 
fname_read = 'test_2cm_valid4.csv';       
validation_data = csvread(fname_read,1,0);
fs=100;

pram1 = 1250;  %1406   1466;    1401  1481;   1361 1561; %1668 1728
pram2 = 1750;

% Lce_initial = 1.163402;
% Lmtu_initial = 1.8;

Lce=validation_data(pram1:pram2,3);   
Lmtu=validation_data(pram1:pram2,4);

% Lce=validation_data(pram1:pram2,4)-Lce_initial;   %?????——?????????0???????
% Lmtu=validation_data(pram1:pram2,5)-Lmtu_initial; %?????——?????????0???????
Pressure=validation_data(pram1:pram2,2);
Tmotor=validation_data(pram1:pram2,5);
emgsend=validation_data(pram1:pram2,6);

numl=length(Lce);
t=0:1/fs:(numl-1)/fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Linear butterworth filter
% fp_low=2;  % 2Hz
% ws=fp_low/(fs/2);
% [b1,a1] = butter(2,ws,'low');   
% Lce_buf=filter(b1,a1,Lce);
% Lmtu_buf=filter(b1,a1,Lmtu);
% Pressure_buf=filter(b1,a1,Pressure);
% Tmotor_buf=filter(b1,a1,Tmotor);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

subplot(4,2,1);
plot(0:1/fs:(numl-1)/fs,emgsend,'b');ylabel('emgsend');xlabel('Time(sec)');box off; %Alpha(mA)  ylim([0 6000]); 

subplot(4,2,3);
plot(0:1/fs:(numl-1)/fs,Tmotor,'b');ylabel('Torque(N.m)');box off;
% plot(0:1/fs:(numl-1)/fs,Tmotor_buf,'b');ylabel('Torque(Nm)');box off;   %???Torque???????

subplot(4,2,5);
plot(0:1/fs:(numl-1)/fs,Lce,'r');ylabel('Length(L0)');hold on;   
plot(0:1/fs:(numl-1)/fs,Lmtu,'b');ylabel('Length(L0)');box off; 
% plot(0:1/fs:(numl-1)/fs,Lce_buf+Lce_initial,'r');ylabel('Length(L0)');hold on;   %???Lce?????
% plot(0:1/fs:(numl-1)/fs,Lmtu_buf+Lmtu_initial,'b');ylabel('Length(L0)');box off;   %???Lmtu?????

subplot(4,2,7);
plot(0:1/fs:(numl-1)/fs,Pressure,'b');ylabel('Pressure(N)');ylim([0 2]);box off;
% plot(0:1/fs:(numl-1)/fs,Pressure_buf,'b');ylabel('Pressure(N)');ylim([0 4]);box off; %???pressure???????

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;
% subplot(3,1,2);plot(0:1/fs:(l2-1)/fs,(rawEMG_v2-min(rawEMG_v2))/(max(rawEMG_v2)-min(rawEMG_v2)),'k');title('rawEMG_v2');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;
% subplot(3,1,3);plot(0:1/fs:(l3-1)/fs,(rawEMG_v3-min(rawEMG_v3))/(max(rawEMG_v3)-min(rawEMG_v3)),'k');title('rawEMG_v3');ylim([0 1]);set(gca,'YTickLabel',{'0','0.5','1.0'},'LineWidth',1.5);xlabel('Time(sec)');
% % set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8'},'LineWidth',1.5);
% box off;





