%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Altera NCO version 13.1
% file : NCO_tb.m
%
% Description : The following Matlab testbench excercises the NCO model NCO_model.m
% generated by Altera's NCO Megacore and outputs the sine and cosine waveforms
% to the variables sin_out and cos_out respectively
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter description
% N : the length of input and output arrays
% fs : the desired sampling rate. For Multi-channel NCO's the channelized sample rate is fs/M 
%      ehre M is the number of channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=2048*1;
fs = 250000.0;
% Input arrays

% phi_inc_i : input phase increment : Length N (required)
phi_inc_i = 1049.*ones(1,N);
% freq_mod_i : frequency modulation input : Length N (optional)
freq_mod_i = zeros(1,N);
% phase_mod_i : phase modulation input : Length N (optional)
phase_mod_i = zeros(1,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function call to generated nco function
[sin_out,cos_out] = NCO_model(phi_inc_i,phase_mod_i,freq_mod_i);
fid_s = fopen('fsin_o_NCO_matlab.txt','w');
fid_c = fopen('fcos_o_NCO_matlab.txt','w');
for i=1:N
  fprintf(fid_s,'%f\n',sin_out(i));
  fprintf(fid_c,'%f\n',cos_out(i));
end
% Plot Channel 0 Time-Domain Output
xvalst = (0:1/fs:((N/1)-1)/fs);
figure,stairs(xvalst,sin_out(1:1:N),'r');
hold on, stairs(xvalst,cos_out(1:1:N),'b');
legend('sine','cosine');
title ('Time-Domain Plot of NCO Channel 0 Output');
grid on;
zoom on;
xlabel ('Time');
ylabel ('Amplitude');

ncofftwinplot(sin_out(1:1:N),fs,0,'r');
ncofftwinplot(cos_out(1:1:N),fs,1,'b');
