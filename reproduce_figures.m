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
% [1] B. Boashash, A. Ghazem, J.M. O' Toole, Time-frequency processing of non-stationary
% signals to aid diagnosis: highlights from medical applications, IEEE Signal Processing
% Magazine, 2013, in press


% John M. O' Toole, University College Cork
% Started: 16-05-2013
%-------------------------------------------------------------------------------
function []=reproduce_figures(fig_num)
if(nargin<1 || isempty(fig_num)), fig_num=1; end


% add path for sub-directories:
load_paths_all;


switch fig_num
  case 1
    generate_Fig1;
  case 2
    generate_Fig2;
  case 3
    generate_Fig3;
  case 4
    generate_Fig4;
  case 5
    generate_Fig5;    
    
  otherwise
    error('input argument must a number between 1 and 5');
end
