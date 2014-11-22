% Copyright (c) 2014, butterworth1492
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
%
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% Author: Jason Miller
% Program: GNU Octave or Matlab
% Input: type => 'spec' is normal magnitude and 'db' is in dB
%        signal => input signal
%        sample_rate => sample rate in Hz
%        center_frequency => where do we want to center the graph
% Output: S => The FFT values
%         X => vector of domain values to plot against
%         XlimMin => lower-bound for graph domain (for axis labeling)
%         XlimMin => upper-bound for graph domain (for axis labeling)
% Notes: If no return values are captured when calling this function, it will
%        generate the plot itself.

function [S,X,XlimMin,XlimMax] = build_fft(type,signal,sample_rate,center_frequency)

  if ( ! strcmp(type,'db') && ! strcmp(type,'spec') )
    printf("\n*****\n");
    printf("First argument should be ('spec'|'db').  \n");
    printf("*****\n");
    return;
  endif

  N = length(signal);
  X = [ -N/2 : (N-1)/2 ] * (sample_rate/N);
  X = X .+ center_frequency;
  XlimMax = (sample_rate / 2) + center_frequency;
  XlimMin = XlimMax - ( (XlimMax - center_frequency) * 2 );

  S = abs(fft(signal,N));
  S = fftshift(S);

  if( strcmp(type, 'db') );
    % This  part is voodoo to me.  Got it from http://www.cs.sfu.ca/~tamaras/matlabtut3/FFT_simple_sinusoid.html
    S = 20*log10(abs(S));
    S -= max(S);
  endif

  if ( nargout() == 0 )
    plot(X,S);
    set(gca,  ...
        'xlim', [XlimMin XlimMax], ...
        'title', '', ...
        'xlabel', 'Frequency (Hz)', ...
        'ylabel', 'Magnitude' ...
      );
  endif


endfunction

