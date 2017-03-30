%-------------------------------------------------------------------------------
% generate_Fig2: Plot instantaneous frequency estimates in Fig. 2 from [1]
%
% Syntax: []=generate_Fig2(a_or_b)
%
% Inputs: 
%     a_or_b - plot sub-figure 2a or 2b (either 'a' or 'b')
%
% Outputs: 
%     [] - none
%
% Example:
%     generate_Fig2('a');
%     generate_Fig2('b');
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
function []=generate_Fig2(a_or_b)
if(nargin<1 || isempty(a_or_b)) a_or_b='a'; end


FONT_TYPE='Times-Roman';
FONT_SIZE=16;


if(~exist('quadtfd','file'))
    disp('------');
    disp('Need to install the TFSA package.');
    disp('(download from http://time-frequency.net/)');
    disp('------');    
    return;
end


switch a_or_b
  case 'a'
    load('HRV-signal.mat');
    Fs=4;
    Nfreq=1024;

    %% HRV CPL IF estimation
    tfd = quadtfd( sig123,541, 1, 'mb', 0.01, Nfreq);
    tfps = tfdpeaks(tfd, 4);
    [cplist cps] = edgelink3(tfps,300); 
    % cplist is the outcome of CPL method, each cell comprises an estimate where the 
    % first column is the frequency location and the second column is the time
    % location. The first three cells are HRV components as shown in the plot below. 
    
    f_scale=2*Nfreq/Fs;

    figure(4); clf; hold on;
    if_law1=filt_if_law(cplist{1}(:,1)./f_scale,Fs,10);
    if_law2=filt_if_law(cplist{2}(:,1)./f_scale,Fs,10);
    if_law3=filt_if_law(cplist{3}(:,1)./f_scale,Fs,10);    
    
    plot(cplist{1}(:,2)/Fs,if_law1,'linewidth',2);  % VLF component
    plot(cplist{2}(:,2)/Fs,if_law2,'linewidth',2);               % LF component
    plot(cplist{3}(:,2)/Fs,if_law3,'linewidth',2);   % HF component
    hold off;

    view(90,-90);    
    xlim([0 180]); ylim([0 0.2])    
    set(gca,'ytick',[0:0.04:0.2]);
    set(gca,'xtick',[0:40:180]);    
    xlabel('Time (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    ylabel('Frequency (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);    
    

    

  case 'b'
    load('newborn_seizure_sample.mat');

    %%  Down sampling for EEG
    Fs=256;
    x=sig1(1:(Fs*20));
    x=resample(x,32,Fs);
    Fs=32;
    res_eeg=x;

    Nfreq=1024;
    
    %%  TFD
    tfd = quadtfd( res_eeg, 127, 1, 'mb', 0.01, Nfreq);
    f_scale=(2*Nfreq)/Fs;

    %%  EEG CPL IF estimation
    tfps = tfdpeaks(tfd,4);
    [cplist cps] = edgelink3(tfps,260); 
    % there are 3 estimated components in the cplist for the EEG signal where
    % there are in fact 2 components. The second component includes two
    % segments. A disconnection can be seen in the plot.

        
    figure(5); clf; hold on;
    for n=1:length(cplist)
        if_smooth=filt_if_law(cplist{n}(:,1)./f_scale,Fs);

        plot(cplist{n}(:,2)./Fs,if_smooth,'linewidth',2);
    end
    xlim([0 20]); ylim([0 5]);
    set(gca,'ytick',[0:1:5]);
    set(gca,'xtick',[0:4:20]);    
    xlabel('Time (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    ylabel('Frequency (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);    
    
    view(90,-90);
    
  otherwise
    error('a or b?');
end



function if_smooth=filt_if_law(if_law,Fs,smooth_win_length)
%---------------------------------------------------------------------
% filter IF law by convolving with Hamming window
%---------------------------------------------------------------------
if(nargin<3 || isempty(smooth_win_length)) smooth_win_length=1; end

w=hamming( floor(smooth_win_length*Fs) ); w=w./sum(w);

if_mean=mean(if_law);
if_smooth=conv(if_law-if_mean,w,'same');
if_smooth=if_smooth+if_mean;
