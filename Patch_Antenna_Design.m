% Patch Antenna Design

% Patch Design Parameters (assume FR4)
ep_r = 8.854e-12 * 4;     % Permittivity of FR4 (F/m)
fc = 75.5e9;              % Center frequency of signal (Hz)
c = 299792458;            % speed of light (m/s)
L = c/(2*fc*sqrt(ep_r));  % Length of patch (m)
lambda = 0.003973509933774834; % Wavelength at 75.5 GHz (m)
W = L;                    % Width of match antenna (m)

% Basic Radiation Pattern
k = 2*pi/lambda; % wavenumber
theta = -90:90;
phi = -90:90;
E_theta = zeros(length(theta));
E_psi = zeros(length(theta));
f = zeros(length(theta));
for i = 1:length(phi)
  for j = 1:length(theta)
    E_theta(i,j) = sin(k*W*sin(theta(j))*sin(phi(i)))*cos(k*L/2*sin(theta(j))*cos(phi(i)))*cos(phi(i))/(k*W*sin(theta(j))*sin(phi(i))/2);
    E_psi(i,j) = - sin(k*W*sin(theta(j))*sin(phi(i)))*cos(k*L/2*sin(theta(j))*cos(phi(i)))*cos(theta(j))*sin(phi(i))/(k*W*sin(theta(j))*sin(phi(i))/2);
    f(i,j) = sqrt(E_theta(i,j)^2 + E_psi(i,j)^2);
  end
end

