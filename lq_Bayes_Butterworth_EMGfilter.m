% % A NONLINEAR FILTER FOR ONLINE BAYESIAN ESTIMATION OF MYOELECTRIC SIGNALS
% % 
% % 
% % Terence D. Sanger, MD PhD
% % Div. Child Neurology and Movement Disorders
% % Stanford University Medical Center
% % 300 Pasteur, room A345
% % Stanford, CA 94305-5235 USA
% % (650)736-2154  fax: 725-7459
% % sanger@stanford.edu


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Preliminary section: load data, set constants, initialize variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set parameters
samplerate = 2000;  %samples per second
noutputs = 50;      %output quantization levels
ratemax = 1.0;        %rectified EMG is normalized to max value of 1
inscale = 4.0;        %arbitrary input scaling 
alpha = 0.0001 / samplerate;                %sets diffusion rate
beta = 1e-24 / (noutputs * samplerate);     %sets probability of sudden jumps

%load the data
v = load('fitts_data.txt');    %datafile has 3 columns:  torque, bicepsEMG, tricepsEMG
biceps = v(:,1);
% triceps = v(3,:)';
% torque = v(1,:)';

%calculate rectified EMG after removing the mean, and normalize
%here, we use only biceps and thus cannot approximate extensor torque
emg_nochop = abs(biceps - mean(biceps));               %essential to remove the mean before rectifying
emg = inscale * ratemax * emg_nochop / max(emg_nochop);       %input prescaling to use full output range
emg(emg>ratemax) = ratemax;                     %make sure we don't go over

%initialize variables
%   x is the latent variable (the driving rate)
%   MAP is the output estimate
x = linspace(ratemax/noutputs, ratemax, noutputs)';  %don't start with zero because requires n=0 exactly to match
MAP = zeros(length(emg),1);                     %store the bayes estimates
g = [(alpha/2) (1 - alpha) (alpha/2)];          %approximate spatial second derivative operator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Following is the main section of the algorithm; steps are numbered as in the text
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1.	Initialize p(x,0) = 1;
prior = ones(noutputs,1) / noutputs;            %start with uniform prior

for t=1:length(emg) %iterate for each sample of EMG
    
    %2.	Forward propagate p(x,t-) ?    %           ?p(x-?,t-1)+(1-2?)p(x,t-1)+?p(x+?,t-1)+?+(1-?)p(x,t-1);
    prior = filtfilt(g, 1, prior);              %drift term by convolving with second derivative operator
    prior = beta + (1-beta) * prior;            %sets probability of a sudden jump
    
    %3.	Measure the rectified emg;
    emgval = emg(t);                            %if this were online, would read a new sample here
    
    %4.	Calculate the posterior likelihood function 
    %       P(x,t) ?P(emg|x)p(x,t-);
    measurement_model = exp(-emgval./x) ./ x;   %exponential model for P(emg|x)
    posterior = measurement_model .* prior;     %calculate posterior density using Bayes rule
    
    %5.	Output the signal estimate MAP(x(t)) = argmax P(x,t);
    pp = min(find(posterior == max(posterior)));    %find the maximum of the posterior density
    if (pp > 1 && pp < length(posterior)),          %interpolate to find the zero 
        dL = posterior(pp-1) - posterior(pp);  
        dR = posterior(pp) - posterior(pp+1); 
        PeakIndex = (pp - .5 - (dL / (dR - dL)));   %index runs from 1 to noutputs
    else
        PeakIndex = pp;    %if maximum occurs at an endpoint do not interpolate
    end
    MAP(t) = (ratemax / (noutputs-1)) * PeakIndex;  %convert index of peak value to scaled EMG value
    
    %6.	Divide p(x,t) by a constant C so that  ?p(x,t) dx = 1;
    posterior = posterior / sum(posterior);        %normalize the density
    
    %7.	Repeat from step 2;
    prior = posterior;                          %prior for next iteration is posterior from this iteration
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Linear butterworth filter

fs=2000;fp_high=40;fp_low=20;fp_low1=10;fp_low2=5;fp_low3=2;fp_low4=1;
wp=fp_high/(fs/2);
[b1,a1] = butter(3,wp,'high');
% data=load('butter_data11.txt');
% data=data(732:1170,1);
l=length(emg_nochop);
t=0:1/fs:(l-1)/fs;
f=(0:l-1)*fs/l;
X=fft(emg_nochop,l);
mag1=abs(X);
y=filter(b1,a1,emg_nochop);
Y=fft(y,l);
mag2=abs(Y);

ws=fp_low/(fs/2);
ws1=fp_low1/(fs/2);
ws2=fp_low2/(fs/2);
ws3=fp_low3/(fs/2);
ws4=fp_low4/(fs/2);
[b2,a2] = butter(3,ws,'low');
y=filter(b2,a2,emg_nochop);
Y=fft(y,l);
mag=abs(Y);

[c1,d1] = butter(3,ws1,'low');
y1=filter(c1,d1,emg_nochop);
Y1=fft(y1,l);
mag1=abs(Y1);
[c2,d2] = butter(3,ws2,'low');
y2=filter(c2,d2,emg_nochop);
Y2=fft(y2,l);
mag2=abs(Y2);
[c3,d3] = butter(3,ws3,'low');
y3=filter(c3,d3,emg_nochop);
Y3=fft(y3,l);
mag3=abs(Y3);
[c4,d4] = butter(3,ws4,'low');
y4=filter(c4,d4,emg_nochop);
Y4=fft(y4,l);
mag4=abs(Y4);



%% show results
emg_nochop_re = biceps - mean(biceps);

% emg_nochop_re(12000:13000)=[];
% torque(12000:13000)=[];
% MAP(12000:13000)=[];
% y4(12000:13000)=[];


figure(1)
clf;
hold on
biceps_emg = abs(biceps - mean(biceps(1:500)));
subplot(411);
plot(emg_nochop_re*7000*2, 'k');
ylim([-2 3]);
subplot(412);
% plot(normalize(torque)*2, 'k');
% ylim([-2 3]);
% subplot(413);
plot(normalize(MAP)*2,'k', 'linewidth', 1.0);
ylim([-2 3]);
subplot(414);
plot(y4*7000*4*2, 'k', 'linewidth', 1.0);
ylim([-2 6]);
hold off
