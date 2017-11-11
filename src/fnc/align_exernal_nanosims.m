function varargout = align_exernal_nanosims(varargin)
% ALIGN_EXERNAL_NANOSIMS MATLAB code for align_exernal_nanosims.fig
%      ALIGN_EXERNAL_NANOSIMS, by itself, creates a new ALIGN_EXERNAL_NANOSIMS or raises the existing
%      singleton*.
%
%      H = ALIGN_EXERNAL_NANOSIMS returns the handle to a new ALIGN_EXERNAL_NANOSIMS or the handle to
%      the existing singleton*.
%
%      ALIGN_EXERNAL_NANOSIMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALIGN_EXERNAL_NANOSIMS.M with the given input arguments.
%
%      ALIGN_EXERNAL_NANOSIMS('Property','Value',...) creates a new ALIGN_EXERNAL_NANOSIMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before align_exernal_nanosims_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to align_exernal_nanosims_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help align_exernal_nanosims

% Last Modified by GUIDE v2.5 22-Aug-2011 08:30:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @align_exernal_nanosims_OpeningFcn, ...
                   'gui_OutputFcn',  @align_exernal_nanosims_OutputFcn, ...
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


% --- Executes just before align_exernal_nanosims is made visible.
function align_exernal_nanosims_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to align_exernal_nanosims (see VARARGIN)

set(handles.figure1,'Name','Align external and nanosims images');
if(nargin>3)
    handles.flag = varargin{1};
    handles.imagedir = varargin{2};
    %handles.additional_settings = varargin{3};
end;

% Choose default command line output for align_exernal_nanosims
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes align_exernal_nanosims wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = align_exernal_nanosims_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function align_help_Callback(hObject, eventdata, handles)
if hObject == handles.what_to_do    
    helpdlg({'1. Use the File menu to *load the images* that you want to align.';
        'Supported formats for external images: TIF, BMP, PNG, or XYZ (e.g. obtained by AFM).';
        'Supported formats for nanosims images: TIF or MAT (e.g. generated by Look@nanoSIMS.';
        '2a. Use the Action menu to *define at least 3 pairs of matching points*. Do this by first defining the point in the left image and then the corresponding matching point in the right image. Repeat this until you define all pairs of points.';
        '2b. Alternatively, if the points were previously defined and saved, *load the list of points* using the File menu.';
        '3. If you want to *modify a point''s position* or *remove a pair of points*, use the corresponding items from the Action menu.';
        '4. If satisfied with the defined pairs of points, use the Action menu to *calculate and show the alignment*.';
        '5. If satisfied with the alignment, use the Action menu to *export the aligned external image*. If not, repeat points 3 and 4.';
        '6. *Save the list of points* using the File menu. They might be useful for the future.';
        '7. For more instructions, read the messages in the Matlab''s command window.'},...
        'What to do?'); 
elseif hObject == handles.how_to_add_points
    helpdlg({'1. Select Add point from the Action menu.';
        '2. First, define a point in the left image. Immediately afterwards, define the corresponding matching point in the right image.';
        '3. When defining a point, use *left* mouse click to *define its position*, or *arrows* to *move* the defined point in fine steps.';
        '4. If satisfied with the point''s position, use *right* mouse click or press *enter* to *confirm* it.';
        '5. Any time you can press Esc to *cancel* the point definition.'},...
        'How to add a point?');
elseif hObject == handles.how_to_modify_point
    helpdlg({'1. Select Modify point from the Action menu.';
        '2. *Choose a point* that you want to modify, either in the left or right image, by *clicking on it* with the *left* mouse button. *Confirm* the point selection using the *right* mouse button or by pressing *enter*.';
        '3. Use *left* mouse botton again to define the *new* point position. Here you can *use arrows* to more accurately place the point.';
        '4. *Confirm* the point''s position using the *right* mouse botton or by pressing *enter*.';
        '5. Any time you can press Esc to cancel this action.'},...
        'How to modify a point?');
elseif hObject == handles.how_to_remove_points
    helpdlg({'1. Select Remove pair of points from the Action menu.';
        '2. Use *left* mouse click to *select* a point for removal, either in the left of right image.';
        '3. Use *right* mouse click or press *enter* to *remove* it.'},...
        'How to remove a pair of points?');
end;

% --------------------------------------------------------------------
function add_point_Callback(hObject, eventdata, handles)
% hObject    handle to add_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('*** Interactive addition of a point.');
fprintf(1,'- Left-click on the image to define a point\n');
fprintf(1,'  - Use arrows to move it\n')
fprintf(1,'- Right-click or Enter to confirm the point location\n');
fprintf(1,'- Press Esc to cancel action\n');

set(gcf, 'pointer', 'cross');
[x y m ax] = my_ginput(handles.figure1);
%[x,y,m]=ginput(1);

if ax == handles.axes1
    if isfield(handles,'extplist')
        plist = handles.extplist;
    else
        plist = [];
    end;
else
    if isfield(handles,'nanosimsplist')
        plist = handles.nanosimsplist;
    else
        plist = [];
    end;
end;

m=1; p=[];
while m~=3 & m~=13 & m~=27
    
    if isempty(p)
        %axes(ax);
        hold on;
        p = plot(x,y,'wo');
    else
        set(p,'xdata',x,'ydata',y);
    end;
    
    [x1 y1 m] = my_ginput(handles.figure1);
    %[x1,y1,m]=ginput(1);
    if isempty(m)
        m=3;
    end;
    xl = get(ax,'xlim');
    yl = get(ax,'ylim');
    if m==28
        x = x-1;
        if x<1, x=1; end;
    end;
    if m==29
        x = x+1;
        if x>ceil(xl(2)), x=ceil(xl(2)); end;
    end;
    if m==30
        y = y-1;
        if y<1, y=1; end;
    end;
    if m==31
        y = y+1;       
        if y>ceil(yl(2)), y=ceil(yl(2)); end;
    end;
    if m==1
        x = x1; y=y1;
    end;
    
end;

set(gcf, 'pointer', 'arrow');

% add defined point to the plist
if m==3 | m==13
    plist = [plist; [x y]];
    n=size(plist,1);
    tt=text(x+diff(xl)/64,y,num2str(n));
    set(tt,'color',[1 1 1])
    fprintf(1,'Point [%d %d] added to the list.\n',x,y);
else
    fprintf(1,'No point added.\n');
end;
% update handles
if ax == handles.axes1
   handles.extplist = plist;
else
   handles.nanosimsplist = plist;
end;  

guidata(hObject, handles);

update_points_Callback(hObject, eventdata, handles);

% if gca == handles.axes1
%     if isfield(handles,'extplist')
%         fprintf(1,'External plist:\n');
%         fprintf(1,'%d %d\n',round(handles.extplist));
%     end;
% else
%     if isfield(handles,'nanosimsplist')
%         fprintf(1,'Nanosims plist:\n');
%         fprintf(1,'%d %d\n',round(handles.nanosimsplist));
%     end;
% end;

% --------------------------------------------------------------------
function remove_point_Callback(hObject, eventdata, handles)
% hObject    handle to remove_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('*** Interactive removal of a pair of points.');
disp(' - Left-click           = select point;');
disp(' - Right-click or Enter = remove selected point and its corresponding pair;');
disp(' - Esc                  = cancel action;');

%[x,y,m,ax]=ginputc(1,'Color','w');

set(gcf, 'pointer', 'hand');
[x y m ax] = my_ginput(handles.figure1);
 
if(isempty(m)) % i.e. Enter was pressed
    m=1;
end;

while m~=3 & m~=13 & m~=27
    
    if ax == handles.axes1
        if isfield(handles,'extplist')
            plist = handles.extplist;
        else
            plist = [];
        end;
    else
        if isfield(handles,'nanosimsplist')
            plist = handles.nanosimsplist;
        else
            plist = [];
        end;
    end;

    if isempty(plist)
        fprintf(1,'List of points empty\n');
        ind = [];
    else
        d = (plist(:,1)-x).^2 + (plist(:,2)-y).^2;
        [m1,ind]=min(d);
        ind=ind(1);
        fprintf(1,'Points %d selected for removal\n',ind);
    end;
    
    [x y m ax] = my_ginput(handles.figure1);
    %[x,y,m]=ginputc(1,'Color','w');

end;

set(gcf, 'pointer', 'arrow');

% remove point from the current plist
if ~isempty(ind) & (m==3 | m==13)
    plist = plist(setdiff([1:size(plist,1)],ind),:);
    fprintf(1,'Points %d removed.\n',ind);
    
    % update handles
    if ax == handles.axes1
       handles.extplist = plist;
       % remove points also from the plist in the complementary image (here
       % nanosims image)
       if ~isempty(ind) & isfield(handles,'nanosimsplist')
            plist = handles.nanosimsplist;
            plist = plist(setdiff([1:size(plist,1)],ind),:);
            handles.nanosimsplist = plist;
       end;
    else
       handles.nanosimsplist = plist;
       % remove points also from the plist in the complementary image (here
       % external image)
       if ~isempty(ind) & isfield(handles,'extplist')
            plist = handles.extplist;
            plist = plist(setdiff([1:size(plist,1)],ind),:);
            handles.extplist = plist;
       end;
    end;  

    update_points_Callback(hObject, eventdata, handles);

end;

guidata(hObject, handles);

function modify_point_Callback(hObject, eventdata, handles)
% hObject    handle to remove_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('*** Interactive modification of a point.');
disp(' - Left-click           = select point;');
disp(' - Right-click or Enter = confirm point selection;');
disp(' - Esc                  = cancel action;');

set(gcf, 'pointer', 'hand');
[x y m ax] = my_ginput(handles.figure1);
 
if(isempty(m)) % i.e. Enter was pressed
    m=1;
end;

while m~=3 & m~=13 & m~=27
    
    if ax == handles.axes1
        if isfield(handles,'extplist')
            plist = handles.extplist;
        else
            plist = [];
        end;
    else
        if isfield(handles,'nanosimsplist')
            plist = handles.nanosimsplist;
        else
            plist = [];
        end;
    end;

    if isempty(plist)
        fprintf(1,'List of points empty\n');
        ind = [];
    else
        d = (plist(:,1)-x).^2 + (plist(:,2)-y).^2;
        [m1,ind]=min(d);
        ind=ind(1);
        fprintf(1,'Point %d selected.\n',ind);
    end;
    
    [x y m newax] = my_ginput(handles.figure1);
    
    if m==1, ax=newax; end;

end;

if m==3 | m==13
    
    set(gcf, 'pointer', 'cross');
    axes(ax);
    x = plist(ind,1);
    y = plist(ind,2);
    xorig=x;
    yorig=y;
    
    % remove the point first
    plist2 = plist(setdiff([1:size(plist,1)],ind),:);
    if ax == handles.axes1
       handles.extplist = plist2;
    else
        handles.nanosimsplist = plist2;
    end;
    
    % update the points, which will effectively delete the point from the
    % displayed image
    update_points_Callback(hObject, eventdata, handles);
    
    % draw the point again, to get a plot handle that we can modify below
    axes(ax); hold on;
    p = plot(x,y,'wo');
            
    fprintf(1,'*** Modify point %d using mouse or arrows.\n',ind);
    fprintf(1,'  - Left-click on the image to place the point\n');
    fprintf(1,'    - Use arrows to move it\n')
    fprintf(1,'  - Right-click or Enter to confirm the point location\n');
    fprintf(1,'  - Press Esc to cancel action\n');

    m=1; 
    while m~=3 & m~=13 & m~=27
        
        set(p,'xdata',x,'ydata',y);

        [x1 y1 m] = my_ginput(handles.figure1);

        if isempty(m)
            m=3;
        end;
        xl = get(ax,'xlim');
        yl = get(ax,'ylim');
        if m==28
            x = x-1;
            if x<1, x=1; end;
        end;
        if m==29
            x = x+1;
            if x>ceil(xl(2)), x=ceil(xl(2)); end;
        end;
        if m==30
            y = y-1;
            if y<1, y=1; end;
        end;
        if m==31
            y = y+1;       
            if y>ceil(yl(2)), y=ceil(yl(2)); end;
        end;
        if m==1
            x = (x1); y=(y1);
        end;
        fprintf(1,'New point position: [%d %d]\n',round(x),round(y));

    end;    

    % add defined point to the plist
    if m==3 | m==13
        plist(ind,1:2) = [x y];
        fprintf(1,'Point %d modified to [%d %d].\n',ind,x,y);
    else
        % use the original point position if Esc was pressed
        plist(ind,1:2) = [xorig yorig];
        fprintf(1,'Point %d unchanged.\n',ind);
    end;

    % update handles
    if ax == handles.axes1
       handles.extplist = plist;
    else
       handles.nanosimsplist = plist;
    end;  
    
    % this will effectively redraw and renumber all the defined points
    % correctly
    update_points_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
    
end;
set(gcf, 'pointer', 'arrow');

% --------------------------------------------------------------------
function show_alignment_Callback(hObject, eventdata, handles)
% hObject    handle to show_alignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

v1 = round(handles.extplist');
v2 = round(handles.nanosimsplist');
align2images(v1,v2,handles.extimage,handles.nanosimsimage);


% --------------------------------------------------------------------
function export_aligned_external_Callback(hObject, eventdata, handles)
% hObject    handle to export_aligned_external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

v1 = round(handles.extplist');
v2 = round(handles.nanosimsplist');
[im, rgb] = align2images(v1,v2,handles.extimage,handles.nanosimsimage);
fprintf(1,'*** Select filename of the aligned external image.\n');
fprintf(1,'* Choose MAT-format if you *care* about the absolute values.\n');
fprintf(1,'* Choose TIF-format if you do not care about the absolute values.\n');
[FileName, bdir, ext] = uiputfile({'*.mat', 'I care about absolute values (*.mat)';
    '*.tif', 'I do not care about the absolute values (*.tif)'},'Select output image filename',handles.imagedir);
if length(FileName)+length(bdir)+length(ext)>3
    fn = [bdir FileName];
    % save aligned template image
    if ext==1
        % in matlab format
        save(fn, 'im', '-v6');
    else
        % in TIF format
        % rescale it first to 0->255
        a=im;
        sc = find_image_scale(a,0,1);
        if sc(2)>sc(1)
            a = (a-sc(1))/(sc(2)-sc(1));
            ind = find(a<0);
            a(ind)=zeros(size(ind));
            ind = find(a>1);
            a(ind)=ones(size(ind));  
        end;    
        im_scaled = a*255;
        imwrite(uint8(im_scaled),fn);
    end;
    fprintf(1,'Aligned image saved as %s\n',fn);
    
    % save also the overlay
    [pathstr, name, ext] = fileparts(fn);
    fn = [pathstr delimiter name '_rgb.tif'];
    imwrite(rgb,fn);
    fprintf(1,'External and Nanosims overlay saved as %s\n',fn);

    % save also the original external and nanosims images separately, with the points
    global additional_settings;
    f1=figure(120);
    hold off;
    im = handles.extimage;
    if size(im,3)>1
        image(im);
    else        
        %sc=quantile(double(im(:)),additional_settings.autoscale_quantiles);
        sc = find_image_scale(double(im(:)),0,1,0);
        imagesc(im,sc);
        colormap(gray);
    end;
    xl = get(gca,'xlim');
    hold on;
    plist = handles.extplist;
    n=size(plist,1);
    for ii=1:n
        p1=plot(plist(ii,1),plist(ii,2),'wo');
        p2=plot(plist(ii,1),plist(ii,2),'w.');    
        tt=text(plist(ii,1)+diff(xl)/64,plist(ii,2),num2str(ii));
        set(tt,'color',[1 1 1],'Fontsize',14,'FontWeight','bold');
    end;
    set(gca,'xticklabel',[],'yticklabel',[],'dataaspectratio',[1 1 1]);
    fn = [pathstr delimiter name '_ext.eps'];
    
    print_figure(gcf,fn,additional_settings.print_factors(1));
    %fprintf(1,'External image with alignment points exported as %s\n',fn);

    close(f1);
    f1=figure(120);
    hold off;
    im = handles.nanosimsimage;
    if size(im,3)>1
        image(im);
    else
        %sc=quantile(double(im(:)),additional_settings.autoscale_quantiles);
        sc = find_image_scale(double(im(:)),0,additional_settings.autoscale_quantiles,0);
        imagesc(im,sc);
        colormap(gray);
    end;
    xl = get(gca,'xlim');
    hold on;
    plist = handles.nanosimsplist;
    n=size(plist,1);
    for ii=1:n
        p1=plot(plist(ii,1),plist(ii,2),'wo');
        p2=plot(plist(ii,1),plist(ii,2),'w.');    
        tt=text(plist(ii,1)+diff(xl)/64,plist(ii,2),num2str(ii));
        set(tt,'color',[1 1 1],'Fontsize',14,'FontWeight','bold');
    end;
    set(gca,'xticklabel',[],'yticklabel',[],'dataaspectratio',[1 1 1]);
    fn = [pathstr delimiter name '_lans.eps'];
    print_figure(gcf,fn,additional_settings.print_factors(1));
    %fprintf(1,'Nanosims image with alignment points exported as %s\n',fn);
    close(f1);
    
else
    fprintf(1,'No valid file selected, nothing done.\n');
end;

a=1;

% --------------------------------------------------------------------
function action_Callback(hObject, eventdata, handles)
% hObject    handle to action (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_images_Callback(hObject, eventdata, handles)
% hObject    handle to load_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_external_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_external_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,newdir,newext] = uigetfile({'*.tif';'*.bmp';'*.png';'*.xyz';'*.*'}, 'Select external image', handles.imagedir);
handles.imagedir = newdir;
handles.extimagefile = [newdir FileName];

if newext==4 % xyz file (AFM) was selected
    fprintf(1,'Reading xyz file.\n');
    %t=readtable(handles.extimagefile,'FileType','text');    
    t=importdata(handles.extimagefile,'\t',0);
    x=t(:,1); y=t(:,2); z=t(:,3);
    clear t;
    % reformat into an image
    xu=unique(x);
    yu=unique(y);
    % recalculate x and y to integer numbers
    x=round(x/max(x)*length(xu));
    y=round(y/max(y)*length(yu));
    im=accumarray([y x], z);
    x_size = length(xu);
    y_size = length(yu);
    zfac = 1e9;
    a=inputdlg({'Desired x-size (in pixels) of the external data',...
        'Desired y-size (in pixels) of the external data',...
        'Conversion factor for z-data'},...
        'Rescale external data',1,...
        {num2str(x_size), num2str(y_size), sprintf('%.1e',zfac)});
    if ~isempty(a)
        x_size = str2num(a{1});
        y_size = str2num(a{2});
        zfac = str2num(a{3});
    end;
    % final resizing and z-rescaling
    im = zfac*imresize(im, x_size/length(xu), 'method','nearest');    
    fprintf(1,'Done.\nZ converted by a factor %.1e, image size rescaled by a factor %.1e.\n',...
        zfac, x_size/length(xu)');
    fprintf(1,'[min max] values = [%.3e %.3e]\n',min(im(:)),max(im(:)));
else
    im=imread(handles.extimagefile);
end;
% for some unknown reason some external images can contain the fourth "color"
if size(im,3)>3
    im = im(:,:,1:3);
end;
handles.extimage=im;
axes(handles.axes1);
if size(im,3)>1
    image(im);
else
    %global additional_settings;
    %sc=quantile(double(im(:)),additional_settings.autoscale_quantiles);
    sc = find_image_scale(double(im(:)),0,1,0);
    imagesc(im,sc);
    colormap(gray);
end;

guidata(hObject, handles);

% --------------------------------------------------------------------
function load_nanosims_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_nanosims_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,newdir,newext] = uigetfile({'*.mat';'*.tif';'*.*'}, 'Select nanoSIMS image', handles.imagedir);
handles.imagedir = newdir;
handles.nanosimsimagefile = [newdir FileName];

if newext == 1
    a=load(handles.nanosimsimagefile);
    im=a.IM;
    if isfield(a,'vscale')
        vscale=a.vscale;
    else
        vscale = find_image_scale(double(im(:)),0,1,0);
    end;
else
    im=imread(handles.nanosimsimagefile);
    vscale = find_image_scale(double(im(:)),0,1,0);
end;
handles.nanosimsimage=im;
if vscale(2)>vscale(1)
    handles.nanosimsimage = (handles.nanosimsimage-vscale(1))/diff(vscale);
    ind0=find(handles.nanosimsimage<0);
    handles.nanosimsimage(ind0)=zeros(size(ind0));
    ind0=find(handles.nanosimsimage>1);
    handles.nanosimsimage(ind0)=ones(size(ind0));
end;

axes(handles.axes2);
if size(im,3)>1
    image(im);
else
    sc=vscale;
    imagesc(im,sc);
    colormap(gray);
end;

guidata(hObject, handles);


% --------------------------------------------------------------------
function load_point_list_Callback(hObject, eventdata, handles)
% hObject    handle to load_point_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,newdir,newext] = uigetfile( '*.mat' , 'Select point-list file', handles.imagedir);

fn = [newdir FileName];
a=load(fn);
fprintf(1,'Point list loaded from %s\n',fn);
plist = a.plist;

%handles.imagedir = plist.imagedir;
%handles.extimagefile = plist.extimagefile;
%handles.nanosimsimagefile = plist.nanosimsimagefile;
handles.extplist = plist.extplist;
handles.nanosimsplist = plist.nanosimsplist;
%im=imread(handles.extimagefile);
%handles.extimage=im;
%[pathstr, name, ext] = fileparts(handles.nanosimsimagefile);

% if strcmp(ext,'.mat') == 1
%     a=load(handles.nanosimsimagefile);
%     im=a.IM;
%     if isfield(a,'vscale')
%         vscale=a.vscale;
%     else
%         vscale=[min(im(:)) max(im(:))];
%     end;
% else
%     im=imread(handles.nanosimsimagefile);
%    vscale=[min(im(:)) max(im(:))];
%end;

%handles.nanosimsimage=im;
% if 0 & vscale(2)>vscale(1)
%     handles.nanosimsimage = (handles.nanosimsimage-vscale(1))/diff(vscale);
%     ind0=find(handles.nanosimsimage<0);
%     handles.nanosimsimage(ind0)=zeros(size(ind0));
%     ind0=find(handles.nanosimsimage>1);
%     handles.nanosimsimage(ind0)=ones(size(ind0));
% end;

guidata(hObject, handles);
update_points_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function save_point_list_Callback(hObject, eventdata, handles)
% hObject    handle to save_point_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,newdir,newext] = uiputfile( '*.mat' , 'Select point-list file', handles.imagedir);
plist.imagedir = handles.imagedir;
plist.extimagefile = handles.extimagefile;
plist.nanosimsimagefile = handles.nanosimsimagefile;
plist.extplist = handles.extplist;
plist.nanosimsplist = handles.nanosimsplist;

fn = [newdir FileName];
save(fn,'plist','-v6');
fprintf(1,'Point list saved as %s\n',fn);


% --------------------------------------------------------------------
function update_points_Callback(hObject, eventdata, handles)
% hObject    handle to update_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im = handles.extimage;
if ~isempty(im)
    axes(handles.axes1); hold off
    if size(im,3)>1
        image(im);
    else
        sc = find_image_scale(double(im(:)),0,1,0);
        imagesc(im,sc);
        colormap(gray);
    end;
    hold on;
    if isfield(handles,'extplist')
        plist = handles.extplist;
        n=size(plist,1);
        xl=get(gca,'xlim');
        fprintf(1,'List of points defined for the external image\n');
        for ii=1:n
            plot(plist(ii,1),plist(ii,2),'wo');
            tt=text(plist(ii,1)+diff(xl)/64,plist(ii,2),num2str(ii));
            set(tt,'color',[1 1 1]);
            fprintf(1,'%d: %d %d\n',ii,round(plist(ii,:)));
        end;
    end;
else
    fprintf(1,'External image empty. Please load it first.\n');
end;

im=handles.nanosimsimage;
if ~isempty(im)
    axes(handles.axes2); hold off;
    if size(im,3)>1
        image(im);
    else
        sc = find_image_scale(double(im(:)),0,1,0);
        imagesc(im,sc);
        colormap(gray);
    end;
    hold on;
    if isfield(handles,'nanosimsplist')
        plist = handles.nanosimsplist;
        n=size(plist,1);
        xl=get(gca,'xlim');
        fprintf(1,'List of points defined for the nanosims image\n');
        for ii=1:n
            plot(plist(ii,1),plist(ii,2),'wo');
            tt=text(plist(ii,1)+diff(xl)/64,plist(ii,2),num2str(ii));
            set(tt,'color',[1 1 1]);
            fprintf(1,'%d: %d %d\n',ii,round(plist(ii,:)));
        end;
    end;
else
    fprintf(1,'Nanosims image empty. Please load it first.\n');
end;