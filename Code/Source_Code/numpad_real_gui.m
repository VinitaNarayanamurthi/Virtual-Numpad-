function varargout = numpad_real_gui(varargin)
% NUMPAD_REAL_GUI MATLAB code for numpad_real_gui.fig
%      NUMPAD_REAL_GUI, by itself, creates a new NUMPAD_REAL_GUI or raises the existing
%      singleton*.
%
%      H = NUMPAD_REAL_GUI returns the handle to a new NUMPAD_REAL_GUI or the handle to
%      the existing singleton*.
%
%      NUMPAD_REAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUMPAD_REAL_GUI.M with the given input arguments.
%
%      NUMPAD_REAL_GUI('Property','Value',...) creates a new NUMPAD_REAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before numpad_real_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to numpad_real_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help numpad_real_gui

% Last Modified by GUIDE v2.5 20-Apr-2019 12:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @numpad_real_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @numpad_real_gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before numpad_real_gui is made visible.
function numpad_real_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to numpad_real_gui (see VARARGIN)

% Choose default command line output for numpad_real_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes numpad_real_gui wait for user response (see UIRESUME)
 %uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = numpad_real_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startbtn.
function startbtn_Callback(hObject, eventdata, handles)
% hObject    handle to startbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 % Load lib
lib = lsl_loadlib();
load('trainedModelworking2.mat');
pause(0.2);

% Filter
% butterworth filter designing
fcut = 60; %Hz
fs=200;
f1 = ((fcut - 2)/ (fs/2));
f2 = ((fcut + 2)/ (fs/2));
[b,a] = butter(3,[f1 f2],'stop');

set(handles.ready,'BackgroundColor','yellow');
set(handles.collect,'BackgroundColor','yellow');
setKeyboard(handles,0)

while true

    % load chunk data
    result = {};
    while isempty(result)
        result = lsl_resolve_byprop(lib,'type','EMG'); 
    end

    set(handles.ready,'BackgroundColor','green');
    set(handles.collect,'BackgroundColor','yellow');
    pause(1);    
    set(handles.ready,'BackgroundColor','green');
    set(handles.collect,'BackgroundColor','green');
    pause(0.02);
    % create a new inlet
    inlet = lsl_inlet(result{1});
    % disp('Now receiving chunked data...');
    % get chunk from the inlet
    x=[];
    for i=1:600
        [vec,ts] = inlet.pull_sample();
        x = [x vec'];
    end

    set(handles.ready,'BackgroundColor','yellow');
    set(handles.collect,'BackgroundColor','yellow');

    % preprocessing
    x2=[];x3=[];x4=[];x5=[];x6=[];x7=[];x8=[];x9=[];
    allfeat = [];
        %[amin,bmin]=min(abs(()));
        x2=filter(b,a,x(2,:)-mean(x(2,:)));
        x3=filter(b,a,x(3,:)-mean(x(3,:)));
        x4=filter(b,a,x(4,:)-mean(x(4,:)));
        x5=filter(b,a,x(5,:)-mean(x(5,:)));
        x6=filter(b,a,x(6,:)-mean(x(6,:)));
        x7=filter(b,a,x(7,:)-mean(x(7,:)));
        x8=filter(b,a,x(8,:)-mean(x(8,:)));
        x9=filter(b,a,x(9,:)-mean(x(9,:)));
    % feature extraction
    numFeatures=5;
    n = 600;    %window length

    %X(1,:) = KSM1[(x2(1,:),n) (x2(1,:),n) (x2(1,:),n) (x2(1,:),n) (x2(1,:),n) (x2(1,:),n) ] ;
    X = [KSM1(x2(1,:),n) KSM1(x3(1,:),n) KSM1(x4(1,:),n) KSM1(x5(1,:),n) ...
                KSM1(x6(1,:),n) KSM1(x7(1,:),n) KSM1(x8(1,:),n) KSM1(x9(1,:),n)];
    featnum=size(X,2);
    xnorm=(X-ones(1,featnum)*min(X))./(ones(1,featnum)*(max(X)-min(X)));
    y = trainedModelworking2.predictFcn(X);
    setKeyboard(handles,y);
    pause(5);
end
