function [outImg, varargout]=tightHistImg(inImg, varargin) % isTight, minQuant, isChanWise, inMap, outMap
%% Deafult params
outMap={};
inMap={};
isChanWise=false;
minQuant=[];
isTight=true;

%% Get user inputs overriding default values
funcParamsNames={'isTight', 'minQuant', 'isChanWise', 'inMap', 'outMap'}; 
assignUserInputs(funcParamsNames, varargin{:});


if isChanWise
    nChans=size(inImg, 3);
    if length(minQuant)~=nChans
        minQuant=repmat( minQuant(1), 1,  nChans );
    end
    
    outImg=zeros( size(inImg), class(inImg) );
    outMap=cell( 1, nChans );
    for iChan=1:nChans
        [outImg(:, :, iChan), outMap{iChan}]=tightHistImgChan( inImg(:, :, iChan),...
            isTight, minQuant(iChan), inMap{iChan}, outMap{iChan} );
    end
else % if isChanWise
    [outImg, outMap]=tightHistImgChan(inImg, isTight, minQuant, inMap, outMap);
end % if isChanWise

if nargout==2
    vargout{2}=outMap;
end

function [outImg, outMap]=tightHistImgChan(inImg, isTight, minQuant, inMap, outMap)

if ~isempty(minQuant) % qunatise
    inImg=minQuant*round(inImg/minQuant);
end
inClass=class(inImg);

if isempty(inMap)
    uniqueInVals=unique(inImg);
    inMap=uniqueInVals; % Source values
end

nInMapVals=length(inMap);
inMin=double( inMap(1) );

if isTight
    % inImg=inImg/minQuant; % now, that all numbers are integers, we can use intlut
    if isempty(minQuant)
        minQuant=double(min( diff(inMap) ));
    end
    outMax=inMin+(nInMapVals-1)*minQuant;
else
    outMax=double( inMap(end) );
end

if isempty(outMap)
    outMap=cast( linspace(inMin, outMax, nInMapVals), inClass); % Target values
end

outImg=zeros( size(inImg), inClass );
for iVal=1:nInMapVals
    outImg( inImg==inMap(iVal) )=outMap(iVal);
end
