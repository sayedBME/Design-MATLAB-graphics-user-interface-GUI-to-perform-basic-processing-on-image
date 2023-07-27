function varargout = Home_Page(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Home_Page_OpeningFcn, ...
                   'gui_OutputFcn',  @Home_Page_OutputFcn, ...
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
function Home_Page_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Home_Page_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function Histogram_Callback(hObject, eventdata, handles)
Histogram

function Edge_Detection_Callback(hObject, eventdata, handles)
Edge_Detect_GUI

function Segmentation_Callback(hObject, eventdata, handles)
Segmentation

function Transformation_Callback(hObject, eventdata, handles)
Transformation

function Filters_Callback(hObject, eventdata, handles)
Filters

function Morphology_Callback(hObject, eventdata, handles)
Morphology

function Close_Callback(hObject, eventdata, handles)
close Home_Page
