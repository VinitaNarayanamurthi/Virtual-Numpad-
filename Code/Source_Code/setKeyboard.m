function setKeyboard(handles,num)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

set(handles.num1,'BackgroundColor','white');
set(handles.num2,'BackgroundColor','white');
set(handles.num3,'BackgroundColor','white');
set(handles.num4,'BackgroundColor','white');
set(handles.num5,'BackgroundColor','white');
set(handles.num6,'BackgroundColor','white');
set(handles.num7,'BackgroundColor','white');
set(handles.num8,'BackgroundColor','white');
set(handles.num9,'BackgroundColor','white');

switch num
    case 1
        set(handles.num1,'BackgroundColor','yellow');
    case 2
        set(handles.num2,'BackgroundColor','yellow');
    case 3
        set(handles.num3,'BackgroundColor','yellow');
    case 4
        set(handles.num4,'BackgroundColor','yellow');
    case 5
        set(handles.num5,'BackgroundColor','yellow');
    case 6
        set(handles.num6,'BackgroundColor','yellow');
    case 7
        set(handles.num7,'BackgroundColor','yellow');
    case 8
        set(handles.num8,'BackgroundColor','yellow');
    case 9
        set(handles.num9,'BackgroundColor','yellow');
end

end