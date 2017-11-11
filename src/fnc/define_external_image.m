function ext_im=define_external_image(p)
ext_im=[];
if isfield(p,'fdir')
    [FileName,newdir,newext] = uigetfile({'*.tif';'*.bmp';'*.png';'*.mat'}, 'Define external image', p.fdir);
    if newdir==0 % this means cancel was pressed
        fprintf(1,'*** Warning: No external image selected.\n');
    else
        fname = [newdir FileName];              
        if exist(fname)
            %global EXTERNAL_IMAGEFILE;
            %EXTERNAL_IMAGEFILE=fname;
            fprintf(1,'External image loaded: %s\n',fname);
            [a b c]=fileparts(fname);
            if strcmp(c,'.mat')
                load(fname);
                ext_im=im;
            else
                ext_im=double(imread(fname));
                ma = max(ext_im(:));
                if ma>0
                    ext_im = ext_im/ma;
                end;
            end;
            figure;
            if size(ext_im,3)==1
                %ext_im = ext_im(:,:,1);
                %warndlg('External image was not B&W. Only the first channel (red) was selected.','Warning','modal');
                imagesc(ext_im);
                set(gca,'dataaspectratio',[1 1 1]);
                colorbar;
                colormap(clut);
            else
                image(ext_im);
                set(gca,'dataaspectratio',[1 1 1]);
            end;                            
        end;
    end;
end;