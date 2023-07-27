function varargout = Edge_Detect_GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Edge_Detect_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Edge_Detect_GUI_OutputFcn, ...
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
function Edge_Detect_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Edge_Detect_GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function LoadImg_Callback(hObject, eventdata, handles)
global gray
[file,path]=uigetfile({'*.*'});
img_loc=fullfile(path,file);
rgb=imread(img_loc);
axes(handles.axes1);
imshow(rgb,[])
title('Uploaded image')
gray=rgb2gray(rgb);

function Apply_Callback(hObject, eventdata, handles)
global gray
k=get(handles.popupmenu1,'value');
switch k
    case 2
        Edge=edge(gray,'Sobel');
    case 3
        Edge=edge(gray,'Prewitt');
    case 4
        Edge=edge(gray,'Roberts');
   case 5
        Edge=edge(gray,'LOG');
        % Laplacian Of Gaussian (LoG)        
   case 6
        Edge=edge(gray,'Canny');
        % Diferrence of Gaussian (DoG)
   otherwise
        disp('No Filter')
end
axes(handles.axes2);
if k==1
    imshow(gray,[])
else 
    imshow(Edge,[])
    title('Edge of image')
end

function popupmenu1_Callback(hObject, eventdata, handles)
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function close_Callback(hObject, eventdata, handles)
close Edge_Detect_GUI
