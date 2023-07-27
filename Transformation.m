function varargout = Transformation(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transformation_OpeningFcn, ...
                   'gui_OutputFcn',  @Transformation_OutputFcn, ...
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

function Transformation_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Transformation_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

function UploadImage_Callback(~, ~, handles)
global x;
[file,path]=uigetfile({'*.*'});
x=fullfile(path,file);
x = imread(x);
axes(handles.axes1);
imshow(x,[])
title('Uploaded image')
% A narrow range of dark input values into a wider range of white output values.
function PowerTrans1_Callback(~, ~, handles)
global x
p=x;
p=rgb2gray(p);
Id=im2double(p);
I_gamma = 1 * Id.^0.1;
axes(handles.axes2)
imshow(I_gamma,[]), 
title('Power Transformation Gamma<1');
% A wide range of white input values into a narrow range of black output values.
function PowerTrans2_Callback(~, ~, handles) 
global x;
y=x;
y=rgb2gray(y);
Id=im2double(y);
I_gamma1 = 1 * Id.^4;
axes(handles.axes2);
imshow(I_gamma1),
title('Power Transformation Gamma>1');
function LogTrans_Callback(~, ~, handles)
global x;
z=x;
z=rgb2gray(z);
Id=im2double(z);
% Expand the values of dark pixels in an image, while compressing the higher-level values
I_log2 = 2 .*log(1+Id);
axes(handles.axes2);
imshow(I_log2,[]),
title('Log Transform By factor 2')

function Thresholding_Callback(~, ~, handles)
global x;
z=x;
z=im2double(z);
Id =z;
T=0.5*(min(min(Id))+max(max(Id)));
deltaT = 0.001;
done = false;
while ~done
g = Id >= T;
Tnext = 0.5*(mean(Id(g)) + mean(Id(~g)));
done = abs(T - Tnext) < deltaT;
T = Tnext;
end
d=im2bw(z,T);
axes(handles.axes2);
imshow(d,[]);
title('Global Thresholding');

function NegativeImg_Callback(~, ~, handles)
global x;
r=x;
r=rgb2gray(im2double(r));
r=1.5 .*log(1+r);
% Enhancing white or gray detail embedded in dark regions of an image.
I_neg = imcomplement(r);
axes(handles.axes2);
imshow(I_neg,[])
title('Negative Image');

function Close_Callback(~, ~, handles)
close Transformation

