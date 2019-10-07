import json, os #basic python packages used to retrieve and manipulate files

import numpy as np #must have numerical package!
import pandas as pd #high level statistics package
import matplotlib.pyplot as plt #python plots made easy

from API import api 
from API import helpers

from os import path

# get api key from local (same path as matlab mainPath)
def startRunning(apiKey, apiPath):
    os.chdir(apiPath);
    print('Key file name: {}'.format(apiKey));
    mvshlfapi = api.MoveshelfApi(apiKey, 'https://api.moveshelf.com/graphql')
    return mvshlfapi

# download data from Moveshelf dataset in json 
def DownloadData(mvshlfapi, clipId):
    print('Download Data from clipID: {}'.format(clipId)) 
    data = mvshlfapi.getAdditionalData(clipId)
    helpers.Helpers.downloadDataToPath(data, clipId)

#display existing projects 
def getProjects(mvshlfapi):
    userProjects = mvshlfapi.getUserProjects()
    return userProjects

# upload file on Moveshelf
def FileInfo(mvshlfapi,filePath, pID,fileN):
    print('Project ID: {}'.format(pID))
    metadata = api.Metadata()
    metadata['title'] = metadata.get('title', path.basename(filePath))
    metadata['allowDownload'] = metadata.get('allowDownload', False)
    metadata['allowUnlistedAccess'] = metadata.get('allowUnlistedAccess', False)
    mvshlfapi.uploadFile(filePath,pID,metadata)
    print('Clip {} uploaded with great success \n'.format(fileN))

# get clips info (given project ID and number of clips to display)
def ClipsInfo(mvshlfapi,pID,lim):
    clips = mvshlfapi.getProjectClips(pID,lim)
    return clips

def UpdateClipInfo(mvshlfapi,clipID, md):
    #cilpID is where to do the change
    #metadata is what you can change 
    metadata = {'title': md[0],
               # 'description': md[1],
                'project': md[1]
                }
    mvshlfapi.updateClipMetadata(clipID, metadata)
    print('Clip updatd \n')

def DeleteClip(mvshlfapi, clip_id):
    mvshlfapi._deleteClip(clip_id)
    print('Clip deleted \n')