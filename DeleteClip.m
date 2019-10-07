function Project = DeleteClip(mvshlfapi, cID)

% Delete clip or more clips from database
mod = py.importlib.import_module('PYinterface');

for i = 1:length(cID)
    mod.DeleteClip(mvshlfapi, cID(i));
    Project = CreateSession(mvshlfapi);
end