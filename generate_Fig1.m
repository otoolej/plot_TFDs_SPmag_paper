%-------------------------------------------------------------------------------
% generate_Fig1: plot time-frequency distributions in Fig 1 from reference [1]
%
% Syntax: []=generate_Fig1(ab_or_c)
%
% Inputs: 
%     ab_or_c - plot sub-figure 1a, 1b, or 1c (use either 'a', 'b', or 'c') 
%
% Outputs: 
%     [] - none
%
% Example:
%     generate_Fig1('a');
%     generate_Fig1('b');
%     generate_Fig1('c');
%     
%
% [1] B. Boashash, G. Azemi, and J.M. O’ Toole, “Time–frequency processing of nonstationary
% signals: advanced TFD design to aid diagnosis with highlights from medical
% applications,” IEEE Signal Process. Mag., vol. 30, no. 6, pp. 108–119, Nov. 2013.
% DOI: 10.1109/MSP.2013.2265914


% John M. O' Toole, University College Cork
% Ghasem Azemi, The University of Queensland
% Started: 13-05-2013
%-------------------------------------------------------------------------------
function []=generate_Fig1(ab_or_c)
if(nargin<1 || isempty(ab_or_c)) ab_or_c='a'; end


if(~exist('quadtfd','file'))
    disp('------');
    disp('Need to install the TFSA package.');
    disp('(download from http://time-frequency.net/)');
    disp('------');    
    return;
end


switch ab_or_c
  case 'a'
   c=load('newborn_seizure_sample.mat');

   Fs=256;
   x=c.sig1(1:(Fs*20));
   x=resample(x,32,Fs);
   Fs=32;
   N=length(x);
   Nfreq=1024; Ntime=floor(N);   

   tf_sep_eeg=quadtfd(x,127,1,'mb',0.01,Nfreq);
   
   plot_TFDs(thres(tf_sep_eeg',0),Fs,5,1);    

   set(gca,'Xtick',[0:1:5]);
   set(gca,'Ytick',[0:4:20]);   
   
  case 'b'
   c=load('nonseiz_seg2_ch5_1_7680.mat');

   Fs=256;
   x=c.sig1(1:(Fs*20));
   x=resample(x,32,Fs);
   Fs=32;
   N=length(x);
   Nfreq=1024; Ntime=floor(N);   

   tf_sep_eeg=quadtfd(x,127,1,'mb',0.01,Nfreq);
   plot_TFDs(thres(tf_sep_eeg',0),Fs,5,2);    

   set(gca,'Xtick',[0:1:5]);
   set(gca,'Ytick',[0:4:20]);   

  case 'c'
   b=load('HRV-signal.mat');

   N=length(b.sig123);
   Nfreq=1024; Ntime=floor(N);   
   
   tf_sep_hrv=quadtfd(b.sig123,N-1,1,'mb',0.01,2*Nfreq);
   
   plot_TFDs(thres(tf_sep_hrv.',0),4,0.2,3);
   set(gca,'Xtick',[0:0.04:0.2]);
   set(gca,'Ytick',[0:40:180]);   

   
  otherwise
    error('Either a,b, or c');
end



function plot_TFDs(tf,Fs,upper_freq_limit,fig_num,db_plot)
%---------------------------------------------------------------------
% plot the TFDs (either dB or linear plot)
%---------------------------------------------------------------------
if(nargin<4 || isempty(fig_num)), fig_num=1; end
if(nargin<5 || isempty(db_plot)), db_plot=0; end


FONT_TYPE='Times-Roman';
FONT_SIZE=16;

figure(fig_num); clf;

if(db_plot)
    tf=tf./max(tf(:));
    vtfd(log(tf),[],Fs);
    set(gca,'clim',[-3,0]); 
% $$$ c=colorbar;
else
    vtfd((tf),[],Fs);
end


if(~isempty(upper_freq_limit))
    xlim([0 upper_freq_limit]);
end

ylabel('Time (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
xlabel('Frequency (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);    

