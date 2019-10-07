function mvshlfapi = selectApiKey()
% select file with API key
% has to be in the same folder as the rest FOR NOW

[keyN, keyP] = uigetfile('*.json');
keyPath = strcat(keyP,keyN);
ak = py.importlib.import_module('PYinterface');
mvshlfapi = ak.startRunning(keyN, keyP); % get project Names
