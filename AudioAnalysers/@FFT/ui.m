function ui(obj, parent)
% Sets up the ui for the FFT Analyser. 
% usage: ui(FFT, parent)
% 
% We rely on picking up the Tag of the uicontrol objects later, so we only
% set them up, we don't return handles to each of them. We can get the handles 
% again in the settings method with handle = findobj('Tag','YourTagHere');
% 
% Make sure the tags you use are unique. The easiest way to do this is to
% use the name of the analyser in the tag at the start, as is done below. 

objName = get(obj, 'Name');

% A popup menu, with some text above it.       
textString = textwrap({'Choose Overlap:'}, 40);
uicontrol('Style', 'text', ...
          'FontSize', 9, ...
          'String', textString,...
          'Parent', parent, ...
          'Units', 'Characters', ...
          'Position', [1 22 46 2],...
          'HorizontalAlignment', 'left', ...
          'BackgroundColor', [0.9 0.9 0.9]);

uicontrol('Style', 'edit', ...
          'String', '75',...
          'FontSize', 9, ...
          'Parent', parent, ...
          'Tag', [class(obj), 'OverlapSize'], ...
          'Units', 'Characters',...
          'Position', [1 20.5 4 1.5], ...
          'BackgroundColor',[0.9 0.9 0.9]);

uicontrol('Style', 'popup', ...
          'String', 'percent|millisecs|secs|samples',...
          'Parent', parent, ...
          'Tag', [class(obj), 'OverlapType'], ...
          'Units', 'Characters',...
          'Position', [5 20 15 2], ...
          'BackgroundColor',[0.9 0.9 0.9]);

% A popup menu, with some text above it.    
textString = textwrap({'Choose a window size:'},40);
uicontrol('Style', 'text', ...
          'FontSize', 9, ...
          'String', textString,...
          'Parent', parent, ...
          'Units', 'Characters', ...
          'Position',[1 17 46 2],...
          'HorizontalAlignment','left', ...
          'BackgroundColor',[0.9 0.9 0.9]);

% Window size text
winSizeH = uicontrol('Style', 'text', ...
                     'Parent', parent, ...
                     'Units', 'Characters',...
                     'String', ['WindowSize = ', num2str(2^11), ' samples'], ...
                     'Position', [16 14.5 37 2], ...
                     'HorizontalAlignment','left', ...
                     'Tag', [class(obj), 'WindowSizeText'], ...
                     'BackgroundColor',[0.9 0.9 0.9]);
pow2str = '2^7';
for p = 8:20
  pow2str = [pow2str, '|2^', num2str(p)];
end

% Window size pop up
pow2winH = uicontrol('Style',  'popup', ...
                     'String', pow2str, ...
                     'Parent', parent, ...
                     'Units', 'Characters',...
                     'Value', 5, ...
                     'Position', [1 15 15 2], ...
                     'Callback', @changeWindowSizeText, ...
                     'Tag', [class(obj), 'WindowSize'], ...
                     'BackgroundColor',[0.9 0.9 0.9]);

% Now for the windowing function
% Some text
textString = textwrap({'Choose a windowing function:'},40);
uicontrol('Style', 'text', ...
          'FontSize', 9, ...
          'String', textString,...
          'Parent', parent, ...
          'Units', 'Characters', ...
          'Position',[1 12 46 2],...
          'HorizontalAlignment','left', ...
          'BackgroundColor',[0.9 0.9 0.9]);

% Popup
% winFuncStr = 'Hanning|Hamming|Bartlett|Blackman|Rectangular';
winFuncStr = 'Hanning|Hamming|Bartlett|Bohman|Gaussian|ModifiedBartlett-Hann|Blackman|BlackmanHarris|Nuttall|Chebyshev100dB|Chebyshev120dB|Chebyshev140dB|Flattop|Rectangular';
uicontrol('Style',  'popup', ...
          'String', winFuncStr, ...
          'Parent', parent, ...
          'Units', 'Characters',...
          'Position', [1 10 16 2], ...
          'Tag', [class(obj), 'WindowFunc'], ...
          'BackgroundColor',[0.9 0.9 0.9]);

% Only do this for FFT
% if strcmp(objName, 'FFT Spectrum'),
%   uicontrol('Style',  'Checkbox', ...
%     'String', 'Use chirp Z-transform', ...
%     'Parent', parent, ...
%     'FontSize', 9, ...
%     'Units', 'Characters',...
%     'Position', [32 7 28 2], ...
%     'Tag', [class(obj), 'UseChirpTransform'], ...
%     'Callback', @zoomCallback, ...
%     'BackgroundColor',[0.9 0.9 0.9]);
% 
%   uicontrol('Style',  'Checkbox', ...
%     'String', 'Do complex average', ...
%     'Parent', parent, ...
%     'FontSize', 9, ...
%     'Units', 'Characters',...
%     'Position', [1 7 28 2], ...
%     'Tag', 'FFTDoComplexAverage', ...
%     'BackgroundColor',[0.9 0.9 0.9]);
% %NOT IMPLEMENTED YET!!!
% 
%   uicontrol('Style', 'Text', ...
%     'String', 'Upper frequency (Hz) :',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'HorizontalAlignment', 'left', ...
%     'Position', [1 4 24 2]);
%   
%   cztF2H = uicontrol('Style', 'edit', ...
%     'String', '',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'Tag', 'FFTChirpF2', ...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'Position', [28 4 10 2]);
%   
%   uicontrol('Style', 'Text', ...
%     'String', 'Lower frequency (Hz) :',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'HorizontalAlignment', 'left', ...
%     'Position', [1 1 24 2]);
%   
%   cztF1H = uicontrol('Style', 'edit', ...
%     'String', '',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Tag', 'FFTChirpF1', ...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'Units', 'Characters',...
%     'Position', [28 1 10 2]);
% 
% % [left bottom width height]
% 
%   uicontrol('Style', 'Text', ...
%     'String', 'Radius :',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'HorizontalAlignment', 'left', ...
%     'Position', [40 4 8 2]);
%   
%   cztF4H = uicontrol('Style', 'edit', ...
%     'String', '',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'Tag', 'Radius2', ...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'Position', [50 4 10 2]);
%   
%   uicontrol('Style', 'Text', ...
%     'String', 'Radius :',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Units', 'Characters',...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'HorizontalAlignment', 'left', ...
%     'Position', [40 1 8 2]);
%   
%   cztF3H = uicontrol('Style', 'edit', ...
%     'String', '',...
%     'FontSize', 9, ...
%     'Parent', parent, ...
%     'Tag', 'Radius1', ...
%     'BackgroundColor', [0.9 0.9 0.9], ...
%     'Units', 'Characters',...
%     'Position', [50 1 10 2]);
% end % if

  % embedded function
  function zoomCallback(src, ev)
    h = [cztF1H cztF2H, cztF3H, cztF4H];
    if get(src, 'Value') == 1
      set(h, 'Enable', 'on');
    else
      set(h, 'Enable', 'off');
      set(h, 'String', '');
    end
  end
end % function

function changeWindowSizeText(hObject, eventdata, arg1)
  % Changes the window size text
  val = get(hObject, 'Value');
  num = 2^(val+6); % 7 is the power of the first index
  str = ['WindowSize = ', num2str(num), ' samples'];

  % Find the tag for the text
  tag = [get(hObject, 'Tag'), 'Text'];
  h   = findobj(get(hObject, 'Parent'), 'Tag', tag);
  
  % See if synchronisation is checked. This comes straight from process.m
  syncH   = findobj('Tag', 'SynchronisationTickbox');
  syncVal = get(syncH, 'Value');
  if syncVal
    syncPopup  = findobj('Tag', 'SynchronisationPopup');
    syncPerVal = get(syncPopup, 'Value');
    syncPerUD  = get(syncPopup, 'UserData');
    syncRate   = 1/(syncPerUD(syncPerVal) * 1e-3); % Convert from ms
  
    offset  = ceil(44.1e3/syncRate); % is this only for fs=44.1 kHz??
    overlap = num - offset;
    
    if overlap > 0
      strOv = sprintf('\nOverlap = %d samples @44.1kHz, %2.2f %%', ...
        overlap, (overlap/num)*100);
    else
      strOv = sprintf('\nOverlap = %d samples @44.1kHz', overlap);
    end
    % Append to string
    str = strcat(str, strOv);
    
    % Change color
    if overlap < 0
      set(h, 'ForegroundColor', [1 0 0]);
    else
      set(h, 'ForegroundColor', [0 0 0]);
    end
  else
    set(h, 'ForegroundColor', [0 0 0]);
  end
  
  % Set the string value
  set(h, 'String', str);
end

% Position is [distanceFromLeft distanceFromBottom width height] 
% Units = Characters gives a certain amount of stability, although it may
% cause some problems on some platforms.

