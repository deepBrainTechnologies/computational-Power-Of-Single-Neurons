%script_make_Xn11_input_signals_Paper2_Model2
%  saved to OUTFOLDER/(UNIFORM/EXPONENTIAL/GAUSSIAN)/
%   subfolder for each set of parameters relevant to PSD/PDF
%      subfolder: '/PARAMETERS_RT_period_%dus__maxJitter_%dsimsteps/'
%
% outfile on each subfolder
% X11_RSsignal_jitter_of_PDF.mat 
%                                file saved with simulation parameters
%                                and jitter times and RS pulses times.
%     
%________________________________________________________________________


%generate input signals  for Model 2 
%                       Model 2 Case 1:(3 lines of fixed delays)
%                       Model 2 Case 2:(3 lines of delays with PDF)
OUTFOLDER = 'd:/DEEPBRAINTECHNOLOGIES/PAPERS/Model2_3DelayLines_ionChans/';
mkdir(OUTFOLDER);

StepsSim  = 2000;
nTrials   = 10;
dtSim     = 0.05; %us

% to feed Simulink (doing on simulink, to reinforce to Nature and
% other publishers that this is cant be meassured invivo, or invitro even)
signals = zeros(nTrials,StepsSim);

%----  define base times of Regular Delta times  ----
RT_period   = 1;               %us  time between pulses, regularly spaced
RT_steps    = RT_period/dtSim; %sim steps between pulses

%---  define (deltas) times  ---
nPulses       = floor(StepsSim/RT_steps)-1;
pulsesTimes    = RT_steps:RT_steps:(nPulses*RT_steps);
pulsesTimes    = repmat(pulsesTimes,nTrials,1);
nPulses       = size(pulsesTimes,2);                   %nPulses per trial
nPulsesTotal  = nPulses*nTrials;

%---  define Jitter Limits  ---
minJitter = 1;
maxJitter = floor(RT_steps*0.3);

%-- generate Jitter for each nPulses ... jitter PDF: Uniform Distribution

%--------------------------------------------------------------------------
SUBFOLDER = '/UNIFORM/';         
jitterValues = classRandomNumbersGenerator.uniform(false,...
                                      nPulsesTotal, minJitter, maxJitter);
jitterValues = round(jitterValues);

pulsesJitteredTimes = pulsesTimes(:) + jitterValues;
pulsesJitteredTimes = reshape(pulsesJitteredTimes,nTrials,nPulses);
signalJitter = signals;
for i=1:1:size(signals,1)
  signalJitter(i,pulsesJitteredTimes(i,:))=1;
end

PDFtype = 'uniform';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%dus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','signalJitter',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');
%--------------------------------------------------------------------------
SUBFOLDER = '/EXPONENTIAL/';                                    
jitterValues = classRandomNumbersGenerator.exponential(false,...
                                      nPulsesTotal,maxJitter/3);
jitterValues = round(jitterValues+1);

pulsesJitteredTimes = pulsesTimes(:) + jitterValues;
pulsesJitteredTimes = reshape(pulsesJitteredTimes,nTrials,nPulses);
signalJitter = signals;
for i=1:1:size(signals,1)
  signalJitter(i,pulsesJitteredTimes(i,:))=1;
end

PDFtype = 'exponential';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%dus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','signalJitter',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');

%--------------------------------------------------------------------------
SUBFOLDER = '/GAUSSIAN/';        
mu_Jitter = 0;
sigma_Jitter = (maxJitter*2);
jitterValues = classRandomNumbersGenerator.gaussian(false,nPulsesTotal, ...
                                                mu_Jitter,sigma_Jitter);
jitterValues = round(jitterValues);

pulsesJitteredTimes = pulsesTimes(:) + jitterValues;
pulsesJitteredTimes = reshape(pulsesJitteredTimes,nTrials,nPulses);
signalJitter = signals;
for i=1:1:size(signals,1)
  signalJitter(i,pulsesJitteredTimes(i,:))=1;
end

PDFtype = 'gaussian';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%dus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','signalJitter',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');




