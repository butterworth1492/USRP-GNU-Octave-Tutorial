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
% Input: signal => vector of complex points
%        passes => order of the filter
%        low_frequency => low cutoff frequency
%        high_frequency => high cutoff frequency
%        sample_rate => sample rate in Hz
% Output: S => vector of complex samples

function [S] = band_pass(signal, passes, low_frequency, high_frequency, sample_rate)
  Nyq = sample_rate / 2;
  fL = low_frequency / Nyq;
  fH = high_frequency / Nyq;

% This was my feeble attempt at tweaking the IIR filter
%  Wp = [low_frequency high_frequency] / Nyq;
%  Ws = [(low_frequency-500) (high_frequency+500)] / Nyq;
%  Rp = -30;
%  Rs = -100;
%  [n,Wn] = buttord(Wp, Ws, Rp, Rs);
%  printf("Butterworth order: %d\n", n);
%  [b,a] = butter(n, Wn);
%  freqz(b,a,128,1000, sample_rate);

  [b,a] = butter(passes, [fL fH]);
%  freqz(b,a,128,1000, sample_rate);

  Si = filter(b, a, real(signal) );
  Sq = filter(b, a, imag(signal) );
  S = complex(Si,Sq);
endfunction


