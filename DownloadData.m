function [] = DownloadData(mvshlfapi, cID)

for i = 1:length(cID) 
    py.PYinterface.DownloadData(mvshlfapi, string(cID(i)));
    disp('File saved!')
end