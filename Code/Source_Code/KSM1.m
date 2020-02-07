function Feat = KSM1(S,n)

% Get the size of the input signal
[samples,channels]=size(S);

% Root squared zero order moment normalized
m0     = sqrt(sum(S.^2));

% Prepare derivatives for higher order moments
d1     = diff(S);
d2     = diff(S,2);

% Root squared 2nd and 4th order moments normalized
m2     = sqrt(sum(d1.^2)./(samples-1));
m4     = sqrt(sum(d2.^2)./(samples-1));

% Sparseness
sparse = (sqrt(abs((m0-m2).*(m0-m4))).\m0);

% Irregularity Factor
IRF    = m2./sqrt(m0.*m4);

% New Features : 

% 1)Root Mean Square Value (Time Domain)
RMS = sqrt((sum((S-mean(S)).^2))./n);
%sqrt((sum((t-mean(t)).^2))./n)

% 2) Mean Absolute Value (Time Domain)
MAV = sum(abs(S))./n;

% 3)Variance(time domain)
VAR = (sum(S.^2)./n-1); 

for i = 1:n-1
% 4)Difference Absolute Standard Deviation Value:(Time Domain)
DAS = sqrt((sum((S(i+1)-S(i)).^2))./n);

% 5)Max Fractal Length - for measuring low level muscle activity (Time Domain)
MFL = log(sqrt((sum((S(i+1)-S(i)).^2))));

% 6) Average Amplitude change(Time Domain)
AAL = ((sum(abs(S(i+1)-S(i))))./n);
end

% All features together
%Feat   = log(abs([(m0) (m0-m2) (m0-m4) sparsi IRF WLR]));
%Feat = log(abs([RMS MAV VAR DAS MFL AAL SSC ZC LOG]));

%Feat = log(abs([RMS VAR DAS MFL AAL MAV SSC ZC ]));

Feat = log(abs([RMS VAR DAS MFL AAL]));

