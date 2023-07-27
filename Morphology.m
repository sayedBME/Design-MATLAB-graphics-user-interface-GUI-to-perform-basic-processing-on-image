function varargout = Morphology(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Morphology_OpeningFcn, ...
                   'gui_OutputFcn',  @Morphology_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function Morphology_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Morphology_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

function UploadImage_Callback(~, ~, handles)
global x;
[file,path]=uigetfile({'*.*'});
x=fullfile(path,file);
x = imread(x);
axes(handles.axes5);
imshow(x,[]);
title('Uploaded Image');
% Dilation “grows” or “thickens” objects in a binary image. 
% Using dilation to repair broken characters in an image.
function Dilation_Callback(~, ~, handles)
global x;
Y=strel('disk',1);
E=imdilate(x,Y);
axes(handles.axes6);
imshow(E,[]);
title ('Dilation');
% Image details smaller than the structuring element are filtered (removed) from the image
function Erosion_Callback(~, ~, handles)
global x;
Y=strel('disk',1);
D=imerode(x,Y);
axes(handles.axes6);
imshow(D,[]);
title ('Erosion');
% Opening generally smoothes the contour of an object, 
% breaks narrow isthmuses, and eliminates thin protrusions.
function Opening_Callback(~, ~, handles)
global x;
i=x;
i=im2bw(i);
SE=strel('disk',10);
IM2=imopen(i,SE);
axes(handles.axes6);
imshow(IM2,[]); 
title ('Opening');
% Smooth sections of contours, but, as opposed to opening, it generally fuses narrow breaks 
% and long thin gulfs, eliminates small holes, and fills gaps in the contour.
function Closing_Callback(~, ~, handles)
global x;
im=x;
im=im2bw(im); 
se = strel('disk',10);
closeBW = imclose(im,se);
axes(handles.axes6);
imshow(closeBW,[]);
title ('Closing');

function Close_Callback(~, ~, handles)
close Morphology

