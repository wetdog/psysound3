function analyserList = getAnalysers()
% GETANALYSERS Return the Analysers in this directory

path = fileparts(mfilename('fullpath'));   % find this directory
analysers = what(path);                    % What's in this directory
analysers = analysers.classes';             % Specifically, which classes are in this directory

i = 1;
% We already have an order we like. We will use that to start with
% Add your analyser here if you would like it to be ordered in the list.
analyserOrder = {...
  'FFT',             ...
  'CZT',            ...
  'Hilbert',         ...
  'Cepstrum',        ...
  'CepstrumComplex', ...
  'AutoCorrelation', ...
  'IACF',            ...
  'SLM',             ...
  'RLB',             ...
  'ThirdOctaveBand', ...
  'CPBFFT',          ...
  'LoudnessCF',      ...
  'LoudnessMGB',    ...
  'LoudnessMG'       ...
  'RoughnessDW',     ...
  'VirtualPitch',    ...
  'MIRPITCH',       ...
  'SWIPEP',			     ...
  'YIN',				     ...
  'Beatroot',        ...
  'Praat',          };

% Get all analysers in the list 
newAnalysers = [];
analyserIndex = 1;

for an = analyserOrder
  if sum(strcmp(analysers,an))
    analyserList(analyserIndex) = an;
    analyserIndex = analyserIndex + 1;
  end
end

% there are some analysers we never want to return - list them here
analysersToHide = {...
  'Analyser',...
  'Resampler',...
  'TemplateAnalyser',...
  'Dissonance',...
  'Articulation',...
  'RoughnessDW2',...
  'mirautocor',...
  'mircepstrum',...
  'psydata',...
  'mirtemporal',...
  'mirdesign',...
  'miraudio',...
  'mirscalar',...
  'psyspectrum'};

for an = analysers
  if ~sum(strcmp(analyserList,an)) && ~sum(strcmp(analysersToHide,an))
    analyserList(analyserIndex) = an;
    analyserIndex = analyserIndex + 1;
  end
end


if length(analysers) > 2
	return
end
% If something's gone wrong default to list below       


% list the analysers in the order that you want them to appear (note - this
% does not affect the output data tree order  - the order there is
% determined by the UI name, not the analyser directory name)
analysers = {...
  'FFT',             ...
  'Hilbert',         ...
  'Cepstrum',        ...
  'CepstrumComplex', ...
  'AutoCorrelation', ...
  'IACF',            ...
  'SLM',             ...
  'RLB',             ...
  'ThirdOctaveBand', ...
  'LoudnessCF',      ...
  'LoudnessMG'       ...
  'RoughnessDW',     ...
  'VirtualPitch',    ...
  'SWIPEP',			...
  'YIN',				...
  'Beatroot',        ...
  'Praat'};

% Or return a sorted list
% analysers = sort(analysers);
