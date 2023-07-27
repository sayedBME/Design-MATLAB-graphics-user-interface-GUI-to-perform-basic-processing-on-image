function varargout = Filters(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Filters_OpeningFcn, ...
                   'gui_OutputFcn',  @Filters_OutputFcn, ...
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

function Filters_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Filters_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function UploadImage_Callback(hObject, eventdata, handles)
global x;
[file,path]=uigetfile({'*.*'});
x=fullfile(path,file);
x = imread(x);
axes(handles.axes1);
imshow(x,[]);
title('Uploaded Image');

function MedianFilter_Callback(hObject, eventdata, handles)
global x;
y=x;
y=rgb2gray(y);
% Each output pixel contains the median value in a 4*4 neighborhood around the corresponding pixel in the input
f= medfilt2(y,[4,4]);
axes(handles.axes2);
imshow(f,[]);
title('MedianFilter');

function AverageFilter_Callback(hObject, eventdata, handles)
global x;
n=x;
n=rgb2gray(n);
% fspecial(type) creates a two-dimensional n*m filter of the specified type
g1=fspecial('average',[3,3]);
% imfilter() Filters the multidimensional array with the multidimensional filter and returns the result in B
b1 = imfilter(n,g1);
axes(handles.axes2);
imshow(b1,[]);
title('Average Filter')

function LaplacianFilter_Callback(hObject, eventdata, handles)
global x;
m=x;
A=rgb2gray(m);
%  Laplacian is always 3*3 filter 
f=fspecial('laplacian');
im=imfilter(A,f);
axes(handles.axes2);
imshow(im,[]);
title('Lablacian Filter');

function Close_Callback(hObject, eventdata, handles)
close Filters
