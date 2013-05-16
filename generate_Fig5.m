%-------------------------------------------------------------------------------
% generate_Fig5: Plot enhanced time-frequency distribution of speech sample 
% (Fig. 5 from [1])
%
% Syntax: []=generate_Fig5()
%
% Inputs: 
%      - 
%
% Outputs: 
%     [] - 
%
% Example:
%     generate_Fig5;
%
% [1] B. Boashash, A. Ghazem, J.M. O' Toole, Time-frequency processing of non-stationary
% signals to aid diagnosis: highlights from medical applications, IEEE Signal Processing
% Magazine, 2013, in press



% John M. O' Toole, University College Cork
% Started: 16-05-2013
%-------------------------------------------------------------------------------
function []=generate_Fig5()


FONT_TYPE='Times-Roman';
FONT_SIZE=16;
lower_db_limit=-45; 
upper_freq_limit=6000; 


%---------------------------------------------------------------------
% load the speech TFD (from .mat file):
%---------------------------------------------------------------------
b=load('speech_sample_TFD_enhanced.mat');
tfd=b.tfd_enhanced; Fs=b.Fs;


%---------------------------------------------------------------------
% and plot:
%---------------------------------------------------------------------
figure(10); clf;
tfd=tfd./max(tfd(:));
vtfd(10*log10(thres(tfd,0)),[],Fs);


set(gca,'clim',[lower_db_limit,0]);
xlim([0 upper_freq_limit]);
set(gca,'XTick',[0:2000:upper_freq_limit]);
% need to re-scale axis as have decimated TFD (to reduce size):
set(gca,'YtickLabel', [get(gca,'Ytick').*40]+0.2); 

ylabel('Time (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
xlabel('Frequency (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);    
