# Reproducing Time–Frequency Plots for Paper: 'Time–frequency processing of non-stationary signals to aid diagnosis', IEEE Signal Processing Magazine, Nov. 2013

This collection of M-files (computer code) generates the figures in

- B. Boashash, G. Azemi, and J.M. O’ Toole, “Time–frequency processing of nonstationary
  signals: advanced TFD design to aid diagnosis with highlights from medical
  applications,” IEEE Signal Process. Mag., vol. 30, no. 6, pp. 108–119,
  Nov. 2013. DOI: [10.1109/MSP.2013.2265914](https://doi.org/10.1109/MSP.2013.2265914)

Requires Matlab or Octave programming environments.

## Files:
- `reproduce_figures.m` : main function to generate the plots
- `load_paths_all.m` : loads all sub-directories into the path
- `generate_FigX.m` : file to generate Fig. X (either: 1,2,3,4, or 5) only

## Directories:
- `data/` : contains Matlab files (.mat) with short epochs of biomedical signals.
- `fastTFDs_v0.23/` : contains files to efficiently generate time-frequency
  distributions. More up-to-date versions of this code is available
  at [fast_TFDs](https://github.com/otoolej/fast_TFDs)
- `IF_est/` : contains code to estimate the instantaneous frequency of the signal. Similar
  code is available at [time\_frequency\_tracks](https://github.com/otoolej/time_frequency_tracks)
- `PLED_IFest/` : contains code to again estimate the instantaneous frequency, but this
  time specifically for epileptiform discharges; up-to-date code available
  at [IF\_estimation\_PLEDs](https://github.com/otoolej/IF_estimation_PLEDs)
- `utils/` : miscellaneous files.


## Requirements
Either Matlab (R2012 or newer, [Mathworks](http://www.mathworks.co.uk/products/matlab/))
or Octave (v3.6 or newer, [GNU Octave](http://www.gnu.org/software/octave/index.html),
with the 'octave-signal' add-on package). In addition, some figures require the
'time–frequency signal analysis (TFSA)' package, available for free download
at <http://time-frequency.net/>. (Please note however that Figs. 1. and 2. cannot be
generated with Octave (Matlab only), as these figures require the TFSA package.)

## Start
Set paths in Matlab, or do so using the `load_paths_all` function:
```matlab
  load_paths_all;
```

To reproduce the figures, open Matlab (or Octave) and run as follows:
```matlab
 reproduce_figures(1);
 %% to plot Fig. 1, and similarly for Fig. 2
 reproduce_figures(2);
 %% and so on.
```

## Version
-   Version: 0.1
-   Last update: 2013-05-16.

## Copyright
Copyright (c) 2013 John M. O' Toole, University College Cork, and Ghasem Azemi, The University
 of Queensland. All rights reserved. 

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

-   Redistributions of source code must retain the above copyright notice, this list of
    conditions and the following disclaimer.
-   Redistributions in binary form must reproduce the above copyright notice, this list of
    conditions and the following disclaimer in the documentation and/or other materials
    provided with the distribution.
-   Neither the name of the University College Cork nor the names of its contributors may
    be used to endorse or promote products derived from this software without specific
    prior written permission.

THIS SOFTWARE IS PROVIDED BY JOHN M. O' TOOLE ''AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JOHN M. O' TOOLE BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
DAMAGE.

## Test computer setup
-   hardware: Intel(R) Xeon(R) CPU @ 2.80GHz; 8GB RAM.
-   operating system: Ubuntu GNU/Linux x86_64 distribution (Raring, 13.04), with
    Linux kernel 3.5.0-28-generic
-   software: Octave 3.6.4 (using Gnuplot 4.6 patchlevel 1), with 'octave-signal' toolbox
    and Matlab (R2009b, R2012a, and R2013a), with 'signal processing' toolbox

## References
1.  B. Boashash, G. Azemi, and J.M. O’ Toole, “Time–frequency processing of nonstationary
    signals: advanced TFD design to aid diagnosis with highlights from medical
    applications,” IEEE Signal Process. Mag., vol. 30, no. 6, pp. 108–119, Nov. 2013.
	DOI: [10.1109/MSP.2013.2265914](https://doi.org/10.1109/MSP.2013.2265914)

## Contact
-   John M. O' Toole,
-   Neonatal Brain Research Group,  
	Irish Centre for Fetal and Neonatal Translational Research ([INFANT](http://www.infantcentre.ie/)),  
	Department of Paediatrics and Child Health,  
	Room 2.19 Paediatrics Bld, Cork University Hospital,  
	University College Cork,  
	Ireland
-   Email j.otoole AT ieee.org; jotoole AT ucc.ie

