% __________________________________________________________________
%   script_X11_analyse_simulations_Paper2_Model2
%___________________________________________________________________

PLOT_DEBUG = false;

INFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
SUBFOLDERS = {'/X11_UNIFORM/','/X11_EXPONENTIAL/','/X11_GAUSSIAN/'};

for pdf_folder=1:1:length(SUBFOLDERS)
  
  SIMFOLDER = [INFOLDER '/' SUBFOLDERS{pdf_folder}];
  cd(SIMFOLDER);
  subfolders = ls; % from 3erd to end
  nFolders = size(subfolders,1);

  for folder = 3:1:nFolders
    cd(subfolders(folder,:));
  
    load('X11_RSsignal_jitter_of_PDF.mat');
   
  
    if(PLOT_DEBUG)
      figure;
    end
    for trial=1:1:nTrials
      PSD_x11(trial,:) = pwelch(X11_signalJitter_binary(trial,:),512);
      PSD_x11(trial,:) = PSD_x11(trial,:)/max(PSD_x11(trial,:));
      PSD_x11(trial,:) = PSD_x11(trial,:)/sum(PSD_x11(trial,:));

      %getting normalized PSD --- (PDF)
      Fs = 1/dtSim;
      nFreqs = size(PSD_x11,2);
      Fvector = (0:1:(nFreqs-1))*((Fs/2)/nFreqs);
      if (PLOT_DEBUG)
        plot(Fvector,PSD_x11(trial,:)); hold all;
      end
      %calculating H(P_X11) from PSD
      Entropy_x11(trial,:) = ...
            sum(PSD_x11(trial,:).*log(1./PSD_x11(trial,:)));
    
    end
  if(PLOT_DEBUG)
  figure;
  plot(1:1:nTrials,Entropy_x11);
  end
  save('X11_PSD_Entropy_Results.mat','Entropy_x11','PSD_x11','Fvector');
  
  cd('..');
  
  
  end %for each parameter combination folder
  
end %for each PDF folder
