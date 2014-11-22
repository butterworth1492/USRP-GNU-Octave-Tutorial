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
% Input: file => raw USRP file name
%        sample_rate => sample rate in Hz
% Output: S => vector of complex samples
%          N => # of samples
%          T => Elapsed signal time in seconds
%          X => X-axis 
%          Fs => sample rate

function [S,N,T,X,Fs] = build_signal(file, sample_rate)
  data = read_float_binary(file);
  I = data( 1 : 2 : length(data)-1 );
  Q = data( 2 : 2 : length(data) );
  S = complex(I,Q);
  S(1:1000) = [];    % Clip off the "USRP spike"
  N = length(S);
  T = N / sample_rate;
  Fs = sample_rate;

  X = [ 0 : T/N : T ];
  X(end) = [];  % Removes last element
endfunction

