function test_viewGetHidden
%Validate calls to viewGet in the hidden inplane view. 
%
%   test_viewGetHidden()
%
% 
% Tests: intiHiddenInplane, viewSet, viewGet
%
% INPUTS
%  No inputs
%
% RETURNS
%  No returns
%
% Example: test_viewGetHidden()
%
% See also MRVTEST TEST_VIEWGETINPLANE
%
% Copyright Stanford team, mrVista, 2012
%
%
%   To make life simple, we would like a number (or numbers) returned from
%   every call. Hence for calls that return text or cell arrays, we
%   calculate some simple statistic like the length of the array.
%
%   Some calls to viewGet, such as 'current scan' and 'current slice' can
%   change if the user has saved preferences with these values. This can
%   happen surreptitously if vista prefs are set to always save preferences
%   upon closing a session. Therefore, we first set the value of these
%   fields before proceeding to the viewGets.  For fields such as 'subject'
%   or 'number of frames' which will not change, we do not use a viewSet.


% Initialize the key variables and data path

% Data directory (where the mrSession file is located)
dataDir = fullfile(mrvDataRootPath,'functional','mrBOLD_01');

% This is the validation file
vFile = fullfile(mrvDataRootPath,'validate','viewCreateDataType');
stored = load(vFile);

% dtNum = viewGet(vw,'Current Data Type');
% dtNum = 2;
% stored.name = dtGet(dataTYPES(dtNum),'Name');
% stored.annotation = dtGet(dataTYPES(dtNum),'Annotation', 1);
% stored.nFrames = dtGet(dataTYPES(dtNum),'nFrames', 1);
% stored.framePeriod = dtGet(dataTYPES(dtNum),'Frame Period', 1);
% stored.numSlices = length(dtGet(dataTYPES(dtNum),'slices', 1));
% stored.numScans = dtGet(dataTYPES(dtNum),'N Scans');
% stored.PfileName = dtGet(dataTYPES(dtNum),'Pfile Name', 1);
% stored.cropSize = dtGet(dataTYPES(dtNum),'Crop Size',1);
% stored.blockedAnalysisParams = dtGet(dataTYPES(dtNum),'Blocked Analysis Params');
% stored.eventAnalysisParams = dtGet(dataTYPES(dtNum),'Event Analysis Params');
% 
% save(vFile, '-struct',  'stored')


% Retain original directory, change to data directory
curDir = pwd;
cd(dataDir);

% Get data structure:
vw = initHiddenInplane;
mrGlobals;

typeName = 'AverageDataType';

%Save dataTYPES to be able to pull it back after we over-write it.
save('dataTYPE_backup','dataTYPES');

vw = averageTSeries(vw, [1 2], typeName,'New Data Type');

dtNum = length(dataTYPES);


%Now that we have created all of the necessary data, we can do the actual
%tests:

try

    assertEqual(stored.name, dtGet(dataTYPES(dtNum),'Name'));
    
    assertEqual(stored.annotation, dtGet(dataTYPES(dtNum),'Annotation', 1));
    
    assertEqual(stored.nFrames, dtGet(dataTYPES(dtNum),'nFrames', 1));
    
    assertEqual(stored.framePeriod, dtGet(dataTYPES(dtNum),'Frame Period', 1));
    
    assertEqual(stored.numSlices, length(dtGet(dataTYPES(dtNum),'slices', 1)));
    
    assertEqual(stored.numScans, dtGet(dataTYPES(dtNum),'N Scans'));
    
    assertEqual(stored.PfileName, dtGet(dataTYPES(dtNum),'Pfile Name', 1));
    
    assertEqual(stored.cropSize, dtGet(dataTYPES(dtNum),'Crop Size', 1));
    
    assertEqual(stored.blockedAnalysisParams, dtGet(dataTYPES(dtNum),'Blocked Analysis Params'));
    
    assertEqual(stored.eventAnalysisParams, dtGet(dataTYPES(dtNum),'Event Analysis Params'));
    
catch
    
    %Even though we failed, we need to clean up:
    load('dataTYPE_backup');
    saveSession;
    rmdir(fullfile(dataDir,'Inplane',typeName),'s');
    
    %Now pass through the error:
    rethrow(exception);
    
end

%Clean up afterwards
load('dataTYPE_backup');
saveSession;
rmdir(fullfile(dataDir,'Inplane',typeName),'s');

cd(curDir);
