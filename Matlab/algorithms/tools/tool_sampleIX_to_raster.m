%__________________________________________________________________________
%
%   function raster = tool_sampleIX_to_raster(samplesIDX,nSimSteps)
%
%     samplesIDX: [nTrials x maxNumSpksPerTrial]  
%                   (nan) when no more spks on that trial
%                   faster than using {nTrials}[variable length]
%__________________________________________________________________________
function raster = tool_sampleIX_to_raster(samplesIDX,nSimSteps)

  nTrials = size(samplesIDX,1)
  %assert((nSimSteps > (max(samplesIDX(:))+1)),'samplesIDX is step index, not time');
  raster = zeros(nSimSteps,nTrials);
  %nSpks = size(samplesIDX,2);

  %samplesIDX = samplesIDX + repmat((0:nSimSteps:nSimSteps*(nTrials-1)),nSpks,1)';
  
  for trial =1:1:nTrials
    idxs = samplesIDX(trial,:);
    idxs = idxs(~isnan(idxs));  %different length on each trial %alternative 
    raster(idxs,trial) = 1;
  end
  
  raster = raster';
  
end
