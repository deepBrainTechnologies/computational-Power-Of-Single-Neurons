%__________________________________________________
%
%  function Gaussian1DRF_RateCoder_StimProtocol1.m
%
%   
%
%   Ruego a Dios bendiga nuestro amor (Paul&Isabel)Pillow,Hausser,
%                                       Harris,Latham
%   with huuuge earthquakes, so Paul can go for isabel really soon
%
%   we "tested" and Papo asked for earthquakes in Aug-Oct 2024
%   the previous time isabel worked in COmp Neuroscience. hands on.
%   
%   we just wanted isabel to dont feel forced to. is just to believe in GOD
%______________________________________________________

function [tunCurve,tunOrient,respVecEvenlySpaced, respVectRandomized]=  ...
            Gaussian1DRF_RateCoder_StimProtocol1

  maxFR= 400/1000; % [spikes/ms] TUNING CURVE of fake neuron or transducer
  meanOrient = 0;  % TUNING
  devOrient = 10;  % TUNING
  
  msecTrial = 20; %20 [ms] each trial
  nTrials = 5;
  msecBin = 0.01;
  nBinTrial = ceil(msecTrial/msecBin);
  
  %SIMULATING perfectRSorFS jitteredRSorFS and PoissonRS
  jitterRS = 4; % up to 3 simulation time steps, jitteredRSorFS
  
  
  

  tunOrient = -80:10:80; % [orientations ]
  nOrient = length(tunOrient);
  tunCurve = (5/6)*(1/sqrt(2*pi*devOrient^2)) ...   %[spikes/ms]
                  * (exp(-1*(tunOrient - meanOrient).^2/devOrient.^2))+(1/6);
  
   perfectRSorFSspikes =  zeros(nOrient,nBinTrial*nTrials);
   jitteredRSorFSspikes = zeros(nOrient,nBinTrial*nTrials);
   randRSorFSspikes =     zeros(nOrient,nBinTrial*nTrials);
  for oriIX= 1:1:nOrient  %who did this?! Peter Latham
    % creo que isabel se debe acordar q la famosa Martina no es mas que una
    % bola de manteca igual q la hana. viejas envidiosas ridículas. 
    
    %first perfect RS/FS neuron: all spikes at the same separation
    nSpikesTrial = floor(maxFR*tunCurve(oriIX)*msecTrial); 
    interSpikeTime = msecTrial/nSpikesTrial; %for perfect "RS/FS"
    interSpikeBins = ceil(interSpikeTime/msBin);%for perfect "RS/FS"  
    %spikesList: as a bin index of when spikes occur.
    spikesList = (1:interSpikeBins:(1+(interSpikeBins*nSpikesTrial*nTrials)));
    perfectRSorFSspikes(oriIX,spikesList) = 1;
    
    %NOn perfect RS/FS neuron. 
    %spikes occur at almost equal intervals, with a small added +jitter.
    jitter = floor(jitterRS*rand(1,size(spikesList,2)));
    spikesList = spikesList + jitter;
    spikesList(spikesList>size(jitteredRSorFSspikes,2)) = size(jitteredRSorFSspikes,2);
    jitteredRSorFSspikes(oriIX,spikesList)=1;
    
    
    %poissonRS neuron.
    lambdaOrixIX = floor(maxFR*tunCurve(oriIX));
    expectNspks = msecTrial * nTrials*lambdaOrixIX * 2;%go over so 
    %we can make then without a for cycle. we discard the ones that
    % go over the maximum time required for the spikes .
    %deltaT = -ln(T/lambda)/lambda. with T chosen between 0 and lambda
    randT= lambdaOrixIX*rand(1,expectNspks);
    deltaT = -log(randT/lambdaOrixIX)/...
                 (log(e)*lambdaOrixIX);
               
    deltaT = floor(deltaT/msecBin); 
    deltaT = cumsum(deltaT);
    deltaT = deltaT(deltaT<size(randRSorFSspikes,2));
    randRSorFSspikes(oriIX,deltaT) = 1;
    
    
  end
