function display_masses_through_mask(handles)

p = load_masses_parameters(handles);

global additional_settings;

[opt1,opt3,opt4]=load_options(handles,1);

% if Maskimg was not defined yet, set it to zero here
if ~isfield(p,'Maskimg')
    p.Maskimg=zeros(size(p.im{1},1),size(p.im{1},2));
else
    % always load it from the last saved cells file
    global CELLSFILE MAT_EXT;
    p.Maskimg = load_cells_from_disk(handles,0,[CELLSFILE MAT_EXT]);
end

% find out the title of the graph
if(isempty(my_get(handles.edit63,'string')))
    tit=fixdir(p.fdir);
else
    tit = my_get(handles.edit63,'string');
end
if tit(end)==filesep
    tit=tit(1:(end-1));
end

if opt1(3) || opt1(6) || opt1(10) || opt1(5) || opt1(13) || opt1(14)
   
    if ~p.planes_aligned
        
        fprintf(1,'*** Warning: Accumulate planes first before displaying mass images!\n');
    
    else

        % get the filename with the classification of cells, so that the
        % histograms can be displayed separately for each cell class
        if opt1(3)
            cellfile = select_classification_file(p); 
        else 
            cellfile=[];    
        end

        % display selected images, and export data if requested
        for ii=1:min([length(p.accu_im) length(opt4)])

            % display accummulated mass image
            if (opt1(6) || opt1(3)) && opt4(ii) 

                if ii<=8 
                    imscale = p.imscale{ii};
                else
                    imscale = p.imscale_full{ii};
                end
                
                % if log10-transformation reqested, make sure min(scale) is
                % not 0
                if opt1(4)                     
                    if imscale(1)==0
                        scale_auto = find_image_scale(p.accu_im{ii}, 0, additional_settings.autoscale_quantiles, opt1(4), 0, p.mass{ii});
                        imscale(1)=scale_auto(1);
                    end
                end
                
                plotImageCells(ii,p.accu_im{ii},p.Maskimg,p.fdir,p.mass{ii},...
                    [my_get(handles.edit62,'string'),'-'],imscale,...
                    opt1,opt3(ii),1,p.scale,tit,cellfile,p.images{ii},p.planes);

                % export image as EPS
                if opt1(6) && opt1(11) 
                    exportImageCells(ii,p.fdir,p.mass{ii},p.ext,...
                        additional_settings.print_factors(1));
                end

            end

        end

        % needed when exporting data as ASCII, or displaying depth
        % profiles, or images with counts/ratios accumulated over ROIs
        m2 = []; dm2=[]; out=[];
        if opt1(10) || opt1(13) || (opt1(5) && opt1(8))

            out=get_Cell_pos_size(p.Maskimg,p.scale);
            
            [m2, dm2]=accumulate_masses_in_cells(p.accu_im,p.Maskimg,p.im,p.images,p.mass);

            for ii=1:min([length(p.accu_im) length(opt4)])
                if opt4(ii) 
                    if isempty(out)
                        fprintf(1,'*** WARNING: No ROIs have been defined, so no data can be exported.\n');
                    else
                        o = [out(:,1:3) m2{ii} dm2{ii} 100*dm2{ii}./m2{ii} out(:,4:7)];
                        export_ascii_data_for_ROIS(o, p.fdir, p.mass{ii}, '.dac', 'd');
                    end
                end
            end
                
        end

        % produce RGB from 3 selected mass images and display it
        if opt1(5)
            
            % ensure that images of accumulated counts in ROIs are not
            % empty
            if opt1(8) 
                if isempty(m2)
                    [m2, dm2]=accumulate_masses_in_cells(p.accu_im,p.Maskimg,p.im,p.images,p.mass);
                end
                if isempty(out)
                    out=get_Cell_pos_size(p.Maskimg,p.scale);
                end
                for ii=1:length(m2)
                    Raim{ii} = cells2image(m2{ii}./out(:,5),p.Maskimg);
                end
            else
                Raim=[];
            end
            
            opt1(9)=0;    
            [rgb7, rgb8, xl, yl, zl] = ...
                construct_RGB_image(handles,p.mass,p.imscale,p.accu_im,Raim,opt1);

            % apply hue modulation, if requested
%             Rconf = 1;
%             if opt1(16)
%                 sic_mass = str2num(get(handles.edit65,'string'));
%                 if ~isempty(sic_mass)
%                     m=p.accu_im;
%                     Rconf = get_ratio_confidence(sprintf('1./m{%d};',sic_mass),m,p.imscale);
%                     for i=1:size(rgb7,3)
%                         rgb7(:,:,i) = rgb7(:,:,i).*Rconf;
%                     end
%                 else
%                     fprintf(1,'WARNING: cannot apply hue modulation. Specify mass ID.\n')
%                 end
%             end
                        
            display_RGB_image(rgb7, rgb8, p, opt1, tit, xl, yl, zl, get(handles.edit62,'string'));
            
        end
        
        % display depth profiles
        if opt1(13)
            
            % accumulate masses in cells over all pixels, but separately in each plane
            [m2, dm2]=accumulate_masses_in_cells(p.im,p.Maskimg,p.im,p.images,p.mass);
            
            % normalize accumulated masses to cell size (divide by pixel
            % number)
            if 0
                for jj=1:length(m2)
                    csize = out(:,5)*ones(1,size(m2{jj},2));
                    m2{jj} = m2{jj}./csize;
                    dm2{jj} = dm2{jj}./csize;
                end
            end
            
            % display depth profiles of masses for all cells
            plot_export_masses_depth(m2, dm2, p.images,p.planes, ...
                opt1, opt4, p.mass, p.fdir, ...
                additional_settings.print_factors(3));

            fprintf(1,'Plotting/exporting depth profiles ... Done.\n');
            
        end
        
        %% display lateral profiles
        if opt1(14)
            % extract the selected planes
            image_stack = p.im;            
            for ii=1:length(image_stack)
                image_stack{ii} = image_stack{ii}(:,:,p.images{ii});
            end
            lateral_profile_gui(p.accu_im,p.imscale,p.mass,...
                p.fdir,p.scale,...
                image_stack,p.mass, ...
                1); %,...
                %additional_settings.print_factors(4));
        end

    end
    
end

% activate the main GUI at the end
figure(handles.figure1);
