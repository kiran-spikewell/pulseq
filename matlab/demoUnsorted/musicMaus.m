%% init the music variables

mrMusic.init('a_init',515); % transpose by something like two and half half-tones to avoid resonances at Prisma (515 Hz works well)

%% melody definition

barDurationSeconds=1.6; 
timeSignature = 4/4; 

% Sendung mit der Maus Main Theme
% 3-voice MRI version by Rebecca Ramb 
melody = {
    % bar 1
    [ais2/8 o/8 d2/8 d2/16 ais2/16 f2/8 o/8 f2/8 o/8], ...
    [d1/2 d1/4 o/4], ...
    [aisbb/8 o/8 aisbb/8 o/8 ab/8 o/8 ab/8 o/8]; ...
    % bar 2
    [f2/8 f2/16 ais2/16 f2/8 f2/16 d2/16 ais1/8 o/16 ais1/16 g1/4], ...
    [d1/2 d1/4 o/4], ...
    [gbb/8 o/8 gbb/8 o/8 fbb/8 o/8 fbb/8 o/8]; ...
    % bar 3
    [ais1/4 d2/4 f2/8 g2/8 g2/4], ...
    [gb/4 gb/8 o/8 ab/4 ab/8 o/8], ...
    [fbb/8 o/8 fbb/8 o/8 disbb/8 o/8 disbb/8 o/8]; ...
    % bar 4
    [ais2/2 a2/4 o/4], ...
    [aisb/2 d1/4 o/4], ...
    [dbb/8 o/8 dbb/8 o/8 fisbb/8 o/8 fisbb/8 o/8]; ...
    % bar 5
    [o/4 g2/8 o/8 g2/4 o/8 d2/16 o/16], ...
    [o/4 d1/8 o/8 d1/4 d1/8 o/8], ...
    [gbb/8 o/8 aisbb/8 o/8 aisbb/8 o/8 cbb/8 o/8]; ...
    % bar 6
    [f2/4 o/8 f2/16 o/16 d2/16 o/16 f2/4 o/8], ...
    [d1/4 o/4 d1/4 o/4], ...
    [dbb/8 o/8 dbb/8 o/8 fbb/8 o/8 dbb/8 o/8]; ...
    % bar 7
    [o/4 g2/8 o/8 g2/4 o/8 d2/16 o/16], ...
    [o/4 d1/8 o/8 d1/4 o/4], ...
    [gbb/8 o/8 dbb/8 o/8 aisbb/8 o/8 cbb/8 o/8]; ...
    % bars 8
    [f2/4 o/8 f2/16 o/16 d2/16 o/16 f2/4 o/8], ...
    [d1/4 o/4 d1/4 o/4], ...
    [dbb/8 o/8 dbb/8 o/8 fbb/8 o/8 dbb/8 o/8]; ...
    % bar 9
    [o/8 ais2/8 o/8 ais2/8 g2/8 g2/8 ais2/8 ais2/8], ...
    [o/8 d1/8 d1/8 o/8 d1/4 o/4], ...
    [gbb/8 o/8 gbb/8 o/8 aisbb/8 o/8 gbb/8 o/8]; ...
    % bar 10
    [o/8 ais2/8 o/8 ais2/16 o/16 g2/8 o/8 ais2/8 o/8], ...
    [g1/4 o/4 g1/4 o/4], ...
    [ebb/8 o/8 ebb/8 o/8 gbb/8 o/8 ebb/8 o/8]; ...
    % bar 11
    [c3/1], ...
    [a1/1], ...
    [fbb/8 gbb/16 o/16 aisbb/16 o/16 gbb/16 o/16 aisbb/16 o/16 gbb/8 gbb/16 o/16 cb/8]; ...
    % bar 12
    [c3/4 o/4 o/2], ...
    [a1/4 o/4 o/2], ...
    [cb/4 aisbb/4 abb/4 gbb/4]; ...
    % bar 13 (rep 1)
    [ais2/8 o/8 d2/8 d2/16 ais2/16 f2/8 o/8 f2/8 o/8], ...
    [d1/2 d1/4 o/4], ...
    [aisbb/8 o/8 aisbb/8 o/8 ab/8 o/8 ab/8 o/8]; ...
    % bar 14 (2?)
    [f2/8 f2/16 ais2/16 f2/8 f2/16 d2/16 ais1/8 o/16 ais1/16 g1/4], ...
    [d1/2 d1/4 o/4], ...
    [gbb/8 o/8 gbb/8 o/8 fbb/8 o/8 fbb/8 o/8]; ...
    % bars 15 (3?)
    [ais1/4 d2/4 f2/8 g2/8 g2/4], ...
    [gb/4 gb/8 o/8 ab/4 ab/8 o/8], ...
    [fbb/8 o/8 fbb/8 o/8 disbb/8 o/8 disbb/8 o/8]; ...
    % bars 16 (4?)
    [ais2/4 o/4 ais3/4 ais3/16 o/16 o/8], ...
    [aisb/4 o/4 ais1/4 ais1/16 o/16 o/8], ...
    [dbb/4 o/4 dbb/4 dbb/16 o/16 o/8]; ...
};    

%% optional frequency (note) scout mode
% use this to optimize the sound on the particular scanner by listnening to 
% the scale or checking the gradSpectrum and forbidden lines and setting 
% 'a_init' above appropriately 

% [melody,timeSignature]=mrMusic.melodyToScale(melody,0.5); % 0.5 means go little slower

%% convert to the channel-frequency table

[pitches, durations] = mrMusic.melodyToPitchesAndDurations(melody,'timeSignature',timeSignature);

%% Pulseq sequence 

% never use full gradient performance because it is almost impossible to
% avoid the mechanical resonances of the gradient system completely
sys = mr.opts('MaxGrad',18,'GradUnit','mT/m',...
    'MaxSlew',160,'SlewUnit','T/m/s',...
    'rfRingdownTime', 20e-6, 'rfDeadtime', 100e-6 ...
);  
seq=mr.Sequence(sys);      % Create a new sequence object

pulseqUseWave=false; % use the "UseWave" option with case as it is really demanding both on the Pulseq environment and the scanner (shape memory)

seq = mrMusic.musicToSequence(seq, pitches, durations, 'barDurationSeconds', barDurationSeconds, 'axesOrder', 'zyx', 'pulseqUseWave', pulseqUseWave);

%% output
if pulseqUseWave
    seq.setDefinition('Name', 'maus');
    seq.write('maus.seq');
else
    seq.setDefinition('Name', 'maus1');
    seq.write('maus1.seq');
end
return
%% play

seq.sound();

return

%% write sound file

sd=seq.sound('onlyProduceSoundData',true);
audiowrite('maus.ogg',sd',44100);

%% optional slow step for checking whether we are staying within slew rate limits  

rep = seq.testReport; 
fprintf([rep{:}]); 
