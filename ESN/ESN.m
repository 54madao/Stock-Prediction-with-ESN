function varargout = ESN(varargin)
% ESN MATLAB code for ESN.fig
%      ESN, by itself, creates a new ESN or raises the existing
%      singleton*.
%
%      H = ESN returns the handle to a new ESN or the handle to
%      the existing singleton*.
%
%      ESN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESN.M with the given input arguments.
%
%      ESN('Property','Value',...) creates a new ESN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESN

% Last Modified by GUIDE v2.5 07-Feb-2014 18:41:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESN_OpeningFcn, ...
                   'gui_OutputFcn',  @ESN_OutputFcn, ...
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


% --- Executes just before ESN is made visible.
function ESN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESN (see VARARGIN)

% Choose default command line output for ESN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ESN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ESN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% get all parameters
dataName=get(handles.pushbutton3,'UserData');
l=length(dataName);
%disp(dataName);
%testNumber=get(handles.edit2,'String');
testNumber=str2double(get(handles.edit2,'String'));
inputUnits=str2double(get(handles.edit4,'String'));
internalUnits=str2double(get(handles.edit5,'String'));
outputUnits=str2double(get(handles.edit6,'String'));
SR=str2double(get(handles.edit7,'String'));
TF=str2double(get(handles.edit8,'String'));
stockName=cell(l,1);
switch get(handles.popupmenu3,'Value')
    case 1
        reservoirType='stdesn';
    case 2
        reservoirType='dlr';
    case 3
        reservoirType='dlrb';
    case 4
        reservoirType='scr';
    case 5
        reservoirType=1;
end

if ~iscell(dataName)
    txtName=dataName;
    l=1;
end
for i=1:l
    % check all parameters
    if  iscell(dataName)
        txtName=char(dataName(i,1));
    end
    index1=strfind(txtName, '@');
    index2=strfind(txtName, '.txt');
    stockName(i,1)=cellstr(txtName(index1+1:index2-1));
    disp(txtName);
    P=checkParameters(txtName,testNumber,inputUnits,internalUnits,outputUnits,SR,TF);
    if P
        if reservoirType
            for j=1:4
                switch j
                    case 1
                        rType='stdesn';
                    case 2
                        rType='dlr';
                    case 3
                        rType='dlrb';
                    case 4
                        rType='scr';
                end
                %excute the main function
                [bestStateMatrix,bestPredictedTestOutput,testoutputSeq,MSEList,time]=main(txtName,testNumber,inputUnits,internalUnits,outputUnits,SR,TF,rType);
                %minVar(i,1) =  min(MSEList');
                %maxVar(i,1) =  max(MSEList');
                %meanVar(i,1) = mean(MSEList);
                totalResult(i,j)= min(MSEList');
                totalResult(i,j+4)= max(MSEList');
                totalResult(i,j+8)= mean(MSEList);
                %set(handles.edit10,'String',num2str(min(minVar)));
                %set(handles.edit11,'String',num2str(max(maxVar)));
                %set(handles.edit12,'String',num2str(mean(meanVar)));
                % create the first nPlotPoints steps input-output plots
                % show MSE
            end
            save mVar;
%         else
%             [bestStateMatrix,bestPredictedTestOutput,testoutputSeq,MSEList,time]=main(dataName,testNumber,inputUnits,internalUnits,outputUnits,SR,TF,reservoirType);
%             nForgetPoints =100 ;
%             time=time(nForgetPoints+1:end,:);
%             Year=year(time);
%             Month=month(time);
%             Day=day(time);
%             set(handles.uitable1,'Data',[Year,Month,Day,testoutputSeq(nForgetPoints+1:end,:),bestPredictedTestOutput]);
%             
%             % create the first nPoints steps internal state plots
%             nPoints = 150 ;
%             uiwait(msgbox('Mission Accomplished','modal'));
%             set(handles.edit10,'String',num2str(min(MSEList')));
%             set(handles.edit11,'String',num2str(max(MSEList')));
%             set(handles.edit12,'String',num2str(mean(MSEList)));
%             set(handles.edit13,'String',num2str(var(MSEList')));
%             %show plot
%             cla(handles.axes1,'reset');
%             cla(handles.axes5,'reset');
%             cla(handles.axes6,'reset');
%             cla(handles.axes7,'reset');
%             cla(handles.axes8,'reset');
%             axes(handles.axes1);
%             title('testing: teacher sequence (green) & predicted sequence (blue)');
%             xlabel('The sequence number of the test sets');
%             ylabel('The closing price');
%             hold on ;
%             plot(testoutputSeq(nForgetPoints+1:end, 1),'g') ;
%             plot(bestPredictedTestOutput) ;
%             %show first 4 internal states
%             axes(handles.axes5);
%             xlabel('The number of steps');
%             hold on ;
%             plot(bestStateMatrix(1:nPoints,1));
%             axes(handles.axes6);
%             xlabel('The number of steps');
%             hold on ;
%             plot(bestStateMatrix(1:nPoints,2));
%             axes(handles.axes7);
%             xlabel('The number of steps');
%             hold on ;
%             plot(bestStateMatrix(1:nPoints,3));
%             axes(handles.axes8);
%             xlabel('The number of steps');
%             hold on ;
%             plot(bestStateMatrix(1:nPoints,4));
        end
    else
        uiwait(errordlg('Please input the correct parameter.', 'Error','modal'));
        set(handles.edit9,'String','');
        set(handles.edit2,'String','50');
        set(handles.edit4,'String','30');
        set(handles.edit5,'String','96');
        set(handles.edit6,'String','1');
        set(handles.edit7,'String','0.8');
        set(handles.edit8,'String','0.8');
    end
end

    
uiwait(msgbox('Mission Accomplished','modal'));
save mVar;
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
set(handles.edit9,'String','');
set(handles.edit2,'String','50');
set(handles.edit4,'String','30');
set(handles.edit5,'String','96');
set(handles.edit6,'String','1');
set(handles.edit7,'String','0.8');
set(handles.edit8,'String','0.8');

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[fileName,pathName] = uigetfile('*.txt','Select the TXT-file','MultiSelect', 'on');

if ~iscell(fileName)
    path = fullfile(pathName,fileName);
    %disp(path);
    if fileName~=0
        if strcmp(fileName(end-3:end),'.txt')
            set(handles.edit9,'String',fileName);
            set(hObject,'UserData',path);
        else
            uiwait(errordlg('This is an error file type.', 'Error','modal'));
        end
    else
        set(hObject,'UserData','0');
    end
else
    %disp(fileName);
    %disp(pathName);
    l=length(fileName);
    %path=zeros(l,1);
    pathall=cell(l,1);
    %disp(l);
    for i=1:l
        str=char(fileName(1,i));
        %disp(str);
        path = fullfile(pathName,str);
        %     data=load(path);
        %     if(length(data)<930)
        %         disp(path);
        %     end
        pathall(i,1)=cellstr(path);
    end
    %disp(pathall);
    str=char(fileName(1,1));
    if str~=0
        if strcmp(str(end-3:end),'.txt')
            str=strcat(str,'...');
            set(handles.edit9,'String',str);
            set(hObject,'UserData',pathall);
        else
            uiwait(errordlg('This is an error file type.', 'Error','modal'));
        end
    else
        set(hObject,'UserData','0');
    end
end


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
set(hObject,'visible','off');
set(handles.uipanel1,'visible','on');
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
set(hObject,'visible','off');
set(handles.uipanel2,'visible','on');
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
set(hObject,'visible','off');
set(handles.uipanel4,'visible','on');
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
set(hObject,'visible','off');
set(handles.uipanel3,'visible','on');
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
set(handles.uipanel2,'visible','off');
set(handles.pushbutton5,'visible','on');
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
set(handles.uipanel1,'visible','off');
set(handles.pushbutton4,'visible','on');

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
set(handles.uipanel4,'visible','off');
set(handles.pushbutton6,'visible','on');
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
set(handles.uipanel3,'visible','off');
set(handles.pushbutton7,'visible','on');
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function pass=checkParameters(dataName,testNumber,inputUnits,internalUnits,outputUnits,SR,TF)
pass=1;
if  strcmp(dataName,'0')
    uiwait(errordlg('dataName can not be null.', 'Error','modal'));
    pass=0;
end
%if length(load(dataName))<1230
if  testNumber<=0 || isempty(testNumber)
    uiwait(errordlg('testNumber should be more than 1.', 'Error','modal'));
    pass=0;
end
if  inputUnits<=0 || isempty(inputUnits)
    uiwait(errordlg('inputUnits should be more than 1.', 'Error','modal'));
    pass=0;
end
if  internalUnits<=0 || isempty(internalUnits)
    uiwait(errordlg('internalUnits should be more than 1.', 'Error','modal'));
    pass=0;
end
if  outputUnits<=0 || isempty(outputUnits)
    uiwait(errordlg('outputUnits should be more than 1.', 'Error','modal'));
    pass=0;
end
if  SR<=0 || isempty(SR) || SR>1
    uiwait(errordlg('SR should be a positive number less than 1.', 'Error','modal'));
    pass=0;
end
if  TF<=0 || isempty(TF) || TF>=1
    uiwait(errordlg('TF should be a positive number less than 1.', 'Error','modal'));
    pass=0;
end

    


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'STD ESN','DLR','DLRB','SCR','ALL'});



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
