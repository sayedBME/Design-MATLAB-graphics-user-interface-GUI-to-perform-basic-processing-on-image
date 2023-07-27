function varargout = Segmentation(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Segmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @Segmentation_OutputFcn, ...
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
function Segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Segmentation_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function Load_Img_Callback(hObject, eventdata, handles)
global Im
[file,path]=uigetfile({'*.*'});
img_loc=fullfile(path,file);
Im=im2double(imread(img_loc));
axes(handles.axes1);
imshow(Im,[]);
title('Uploaded image')

function pushbutton2_Callback(hObject, eventdata, handles)
global Im 
[~,~,r]=size(Im);

if r==3
I=rgb2gray(Im);
[x,y]=ginput(1);
x = round(x); y = round(y);
% Seed Point (x,y)
hold on; plot(x,y,'xg'); hold off;
J = regiongrowing(I,y,x,0.1);
B=imoverlay(I,J,'yellow');
axes(handles.axes2);
imshow(B,[])
title('Segmented Image')

else
[x,y]=ginput(1);
x = round(x); y = round(y);
% Seed Point (x,y)
hold on; plot(x,y,'xg'); hold off;
J = regiongrowing(Im,y,x,0.1);
B=imoverlay(Im,J,'yellow');
axes(handles.axes2);
imshow(B,[])
title('Segmented Image')
end

function Close_Callback(hObject, eventdata, handles)
close Segmentation
