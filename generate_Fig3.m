%-------------------------------------------------------------------------------
% generate_Fig3: Plot time-frequency distributions for Fig. 3 in [1]
%
% Syntax: []=generate_Fig3(ab_or_c)
%
% Inputs: 
%     ab_or_b - plot sub-figure 3a, 3b, or 3c (either 'a', 'b' or 'c')
%
% Outputs: 
%     [] - none
%
% Example:
%     generate_Fig3('a');
%     generate_Fig3('b');
%     generate_Fig3('c');
%     
%
% [1] B. Boashash, A. Ghazem, J.M. O' Toole, Time-frequency processing of non-stationary
% signals to aid diagnosis: highlights from medical applications, IEEE Signal Processing
% Magazine, 2013, in press


% John M. O' Toole, University College Cork
% Started: 08-01-2013
%-------------------------------------------------------------------------------
function []=generate_Fig3(ab_or_c)
if(nargin<1 || isempty(ab_or_c)) ab_or_c='lfm'; end

N=1024; 
Fs=64;

FONT_TYPE='Times-Roman';
FONT_SIZE=16;


switch ab_or_c
  case 'a'
    Fs=1; N=128;
    t=(0:(N-1))./Fs;
    t1=floor(N/4); t2=floor(3*N/4);
    f1=0.1*Fs; f2=0.3*Fs;
    a1=exp(-t.^2/100);
    
    a1=exp(-(t-t1).^2/100) .* exp(j*2*pi.*(t.*f1));    
    a2=exp(-(t-t2).^2/100) .* exp(j*2*pi.*(t.*f2));        
    
    x=real(a1+a2);
    
    %---------------------------------------------------------------------
    % generate ambiguity function (Doppler-lag)
    %---------------------------------------------------------------------
    z=check_analytic_signal(x);
    tf=dtfd_nonsep(z,'wvd',{});
    tf=tf(1:2:end,:);
    A=fft(ifft(tf).').';


    %---------------------------------------------------------------------
    % plot
    %---------------------------------------------------------------------
    figure(6); clf;
    g=cosh_cosh_kern(N,0.02,0.6);
    plot_AF(A,Fs,N,g);

    
  case 'b'
    Npart=floor(N*0.66);
    Ts=[Npart,N-Npart]; alphas=[0.08,-0.04]; f0=0.05; 
    
    % fundamental:
    x=gen_PWLFM_model(N,Ts,alphas,f0);
    % harmonics:
    y=gen_PWLFM_model(N,Ts,3.*alphas,3.*f0);
    x=x+y;
    
    z=check_analytic_signal(x);
    tf=dtfd_nonsep(z,'wvd',{});
    tf=tf(1:2:end,:);

    %---------------------------------------------------------------------
    % plot
    %---------------------------------------------------------------------
    figure(7); clf; vtfd(thres(tf,0));
    set(gca,'ytick',[1, N]);
    set(gca,'yticklabel',[0, N/Fs]);
    set(gca,'xtick',[0,0.5]);
    set(gca,'xticklabel',[0, Fs/2]);

    ylabel('Time (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    xlabel('Frequency (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
    set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);

  case 'c'
    Npart=floor(N*0.66);
    Ts=[Npart,N-Npart]; alphas=[0.08,-0.04]; f0=0.05; 
    
    % fundamental:
    x=gen_PWLFM_model(N,Ts,alphas,f0);
    % harmonics:
    y=gen_PWLFM_model(N,Ts,3.*alphas,3.*f0);
    x=x+y;
    
    z=check_analytic_signal(x);
    tf=dtfd_nonsep(z,'wvd',{});
    tf=tf(1:2:end,:);
    A=fft(ifft(tf).').';
  
    %---------------------------------------------------------------------
    % plot
    %---------------------------------------------------------------------
    figure(8); clf;  plot_AF(A,Fs,N,[]);

  otherwise
    error('??');
end



function [x,tf]=gen_PWLFM_model(N,Ts,alphas,f0,WITH_TFD)
%---------------------------------------------------------------------
% generate piecewise-LFM model with harmonics
%---------------------------------------------------------------------
if(nargin<5 || isempty(WITH_TFD)) WITH_TFD=0; end

x1=zeros(N,1); x=zeros(N,1);

fend=f0+alphas(1); iend=Ts(1);
x1tmp=real( gen_LFM(Ts(1),f0,fend) );
x1(1:Ts(1))=x1tmp; 
x=x+x1;

if(WITH_TFD)
    tftmp=dtfd_nonsep(x,'wvd',{});
    tf=tftmp(1:2:end,:);
end

for n=1:length(Ts)-1    
    xp=zeros(N,1);
    
    fstart=fend;
    fend=fstart+alphas(n+1);
    xptmp=real( gen_LFM(Ts(n+1),fstart,fend) );

    istart=iend; iend=istart+length(xptmp);
    xp((istart+1):iend)=xptmp;
    x=x+xp;
    
    if(WITH_TFD)
        tftmp=dtfd_nonsep(xp,'wvd',{});
        tf=tf+tftmp(1:2:end,:);
    end
end



function []=plot_AF(A,Fs,N,g)
%---------------------------------------------------------------------
% Plot the magnitude of the AF (Doppler-lag) using a dB scale
%---------------------------------------------------------------------
FONT_TYPE='Times-Roman';
FONT_SIZE=16;


A=A./max(A(:));
imagesc(log(abs(fftshift(A)))); axis('xy');
if(~isempty(g))
  hold on;
  iso_lines=[log(0.75),log(0.75); ...
             log(0.5),log(0.5); ...
             log(0.25),log(0.25)];
  [C,hc]=contour(log(g),iso_lines);
  [C,hc2]=contour(log(g),iso_lines);
  set(hc2,'linewidth',1.5);
  set(hc2,'linecolor','r');
  set(hc,'linewidth',3);
  set(hc,'linecolor',[0.9 0.9 0]);
end

ylabel('Doppler (Hz)');
xlabel('lag (secs)');
set(gca,'clim',[-5,0]); 

set(gca,'ytick',[1, floor(N/2), N]);
set(gca,'yticklabel',[-(Fs/2),0,(Fs/2)]);
set(gca,'xtick',[0,0.25,0.5]);
set(gca,'xtick',[1, floor(N/2), N]);
set(gca,'xticklabel',[-N/Fs,0,N/Fs]);

xlabel('Lag (secs)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
ylabel('Doppler (Hz)','FontName',FONT_TYPE,'FontSize',FONT_SIZE);
set(gca,'FontName',FONT_TYPE,'FontSize',FONT_SIZE);



function g=cosh_cosh_kern(N,beta1,beta2)
%---------------------------------------------------------------------
% extended modified B-kernel (cosh-cosh separable kernel)
%---------------------------------------------------------------------
g2=shiftWin( get_window(N-1,'cosh',beta1,0,N) );

G1=get_window(N-1,'cosh',beta2,1,N); G1=real(G1);
G1=shiftWin( G1./max(G1) );

g=G1*g2.';

