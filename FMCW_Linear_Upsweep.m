clear all
close all

% Define initial configuration
B = 1.0e9;  % linear sweep bandwidth
Tm = 0.001; % linear sweep period
fc = 75e9;  % base frequency
fn = 1/(72e6)*(1/4);  % 72 Msps (72 Megasamples per second) * (1/4) sample rate per channel
a1 = 1.0; % Transmit Amplitude

% Define the transmit signal
t = 0.0:Tm/1000:Tm; % discrete time vector
s1 = a1*cos(2*pi*fc.*t + pi*(B/Tm).*t.^2);
%figure
%plot(t/Tm,s1);
%xlabel('Relative Time t/Tm');
%ylabel('Amplitude (V)');
%title('Transmitted Linear Ramp Signal');

% Define the transmit signal frequency
phi = 2*pi*fc.*t + pi*(B/Tm).*t.^2;
F = fc + (B/Tm).*t;
%figure;
%plot(t/Tm, F/(1e9));
%xlabel('Relative Time t/Tm');
%ylabel('Frequency (GHz)');
%title('Frequency of Chirp Signal Over Chirp Period');

% Determine the frequency if target is stationary relative to antenna
r = 500; % 500 meter distance to target
c = 299792458; % speed of light (m/s)
tau = 2*r/c;
fbeat = B*tau / Tm;

% Compute discrete signal returned to the receiver antenna
a2 = 0.01;
s2 = a2*cos(2*pi*fc.*(t-tau) + pi*(B/Tm).*(t-tau).^2);
%figure
%plot(t/Tm,s2);
%xlabel('Relative Time t/Tm');
%ylabel('Amplitude (V)');
%title('Recieved Linear Ramp Signal');

% Compute the discrete signal coming out of the mixer
t = 0:fn:Tm; % new time vector representing sample time
a3 = 0.1;
s3 = a3*cos(2*pi*fbeat.*t + 2*pi*fc*tau - pi*(B/Tm)*tau^2);
%figure
%plot(t*1e6, s3);
%xlabel('Time (us)');
%ylabel('Post Mixer Amplitude (V)');
%title('Post Recieve Mixer Signal');

% Look at reflected power and transmission losses
Pt = 0.1; % watts transmitted power
omega = 1; % m^2 cross section
Gt = 10; % Transmit antenna gain
Glambda = 10; % Receive antenna gain
lambda = 0.003973509933774834; % Wavelength at 75.5 GHz
Pr = Pt*omega*Gt*Glambda*lambda^2/((4*pi)^3 * r^4);

% FFT of received signal
N = length(s3);
S3 = abs(fft(s3));               % Retain Magnitude
S3 = S3(1:N/2);                  % Discard Negative Frequencies
f = ((1/fn)*(0:N/2-1))/(N*1e6);  % Prepare freq data for plot

% Plot FFT of s3
figure
plot(f, S3);
xlabel('Frequency (MHz)');
ylabel('Amplitude');
title('FFT of Post Mixed Signal');

% Determine distance based on beat frequency
[val, loc] = max(S3);
dr = c/(2*B);
fm = 1/Tm;
R = 1e6*f(loc)*dr/fm;
figure
plot([0,R], [0,0]);
xlabel('Target Distance (m)');
ylabel('Target Distance (m)');
title('1D RADAR Target Resolution');