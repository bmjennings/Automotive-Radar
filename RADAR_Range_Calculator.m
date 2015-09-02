% Radar Range Calculation
Pt = 0.01585; % Transmit power (watts)
R = 10;       % Distance to target (meters)
lambda = 0.003973509933774834; % Wavelength at 75.5 GHz (m)
sigma = 50;    % Target cross section (m^2)

% Calculate Input Thermal Noise
k = 1.3806488e-23;  % Boltzmann Constant (J/K)
T0 = 290;           % Temperature (K)
Bn = 4e6;           % Low Pass Filter Bandwidth
NT = 10*log10(1000*k*T0*Bn); % Thermal Noise (dBm)

% Calculate Power before the AD8285
Ppa = 12; % Pre-amp power (dBm)
Gtx = 8;  % TX Antenna gain (dBi)
Df  = 10*log10(((4*pi)^3 * R^4) / (sigma*lambda^2)); % Free space attenuation (dB)
Grx = 8;  % RX Antenna gain (dBi)
Pin = Ppa + Gtx - Df + Grx; % Input Power of echo (dBm)
SNRin = Pin - NT;  % Signal to Noise Ratio at input of receiver circuit

% Account for the noise figure of the receiver
Fad = 17;             % noise figure of AD8285 (dB)
SNRout = SNRin - Fad; % SNR 