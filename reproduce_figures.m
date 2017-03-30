%-------------------------------------------------------------------------------
% reproduce_figures: Generate the figures from [1]
%
% Syntax: []=reproduce_figures(fig_num)
%
% Inputs: 
%     fig_num - which figure to generate? (either 1,2,3,4, or 5)
%
% Outputs: 
%     [] - none
%
% Example:
%     reproduce_figures(1);
%
%
% [1] B. Boashash, G. Azemi, and J.M. O’ Toole, “Time–frequency processing of nonstationary
% signals: advanced TFD design to aid diagnosis with highlights from medical
% applications,” IEEE Signal Process. Mag., vol. 30, no. 6, pp. 108–119, Nov. 2013.
% DOI: 10.1109/MSP.2013.2265914



% John M. O' Toole, University College Cork
% Started: 16-05-2013
%-------------------------------------------------------------------------------
function []=reproduce_figures(fig_num)
if(nargin<1 || isempty(fig_num)), fig_num=1; end


% add path for sub-directories:
load_paths_all;


switch fig_num
  case 1
    if( exist('octave_config_info') )
        disp('Figs. 1 and 2 cannot be generated with Octave (Matlab only).');
        return;
    end
    generate_Fig1('a');     
    generate_Fig1('b');
    generate_Fig1('c');    
  case 2
    if( exist('octave_config_info') )
        disp('Figs. 1 and 2 cannot be generated with Octave (Matlab only).');
        return;
    end
    generate_Fig2('a');     
    generate_Fig2('b');
  case 3
    generate_Fig3('a');     
    generate_Fig3('b');
    generate_Fig3('c');    
  case 4
    generate_Fig4;
  case 5
    generate_Fig5;    
    
  otherwise
    error('input argument must a number between 1 and 5');
end
