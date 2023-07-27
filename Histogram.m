function varargout = Histogram(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Histogram_OpeningFcn, ...
                   'gui_OutputFcn',  @Histogram_OutputFcn, ...
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
function Histogram_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = Histogram_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function Upload_Img_Callback(hObject, eventdata, handles)
global a
[file,path]=uigetfile({'*.*'});
img_loc=fullfile(path,file);
a=imread(img_loc);
axes(handles.axes1);
imshow(a,[])
title('Uploaded image')

function Histogram_Callback(hObject, eventdata, handles)
global a
axes(handles.axes1);
imshow(a,[])
gray=rgb2gray(a);
title('Original image')
axes(handles.axes2);
imhist(gray)
title('Histogram of Original image')

function Histogram_Equalization_Callback(hObject, eventdata, handles)
global a
hist_adj=histeq(a);
axes(handles.axes1);
imshow(hist_adj)
title('Enhanced Image')
axes(handles.axes2);
imhist(hist_adj)
title('Equalized Histogram')

