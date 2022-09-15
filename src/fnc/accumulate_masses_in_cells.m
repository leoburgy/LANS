function [m,dm]=accumulate_masses_in_cells(m, CELLS, im, images, mass_names)
% accumlate masses for each cell in every plane, return also the standard
% Poisson error of the mean mass (SE=mean/sqrt(mean))

be_verbous=0;

if be_verbous
    fprintf(1,'This is function: %s\n','accumulate_masses_in_cells');
end

if ~iscell(m)
    mm=m;
    m=[];
    m{1}=mm;
end

Nmasses=length(m);
Nc=length(setdiff(unique(CELLS),0));

if Nc>0
    
    if be_verbous
        if size(m{1},3)>1
            fprintf(1,'Accumulating counts in each ROI for every plane ...\n');
        else
            fprintf(1,'Accumulating counts in each ROI ...\n');
        end
    end
    
    t1 = clock;
    
    for kk=1:Nmasses

        tmp = m{kk};
        L=size(tmp,3);
        rcell = zeros(Nc,L);
        
        for ii=1:Nc
            ind = find(CELLS==ii);
            
            % set 1 to 0 if you want to apply a special hack for Anne R
            if 1
                % this is the normal way to calculate accumulated values
                for jj=1:L
                    mplane=squeeze(tmp(:,:,jj));
                    a = mplane(ind);
                    indN = find(isfinite(a));            
                    rcell(ii,jj) = sum(a(indN));
                end;
                
            else
                
                % ------------------------------------
                % this is a hack for Anne R
                % ------------------------------------
                fprintf(1,'\nApplying hack for Anne R (mass %d, ROI %d) ...',kk,ii);
                mass_ind1 = identifyMass(mass_names,'44Ca');
                mass_ind2 = identifyMass(mass_names,'24Mg');
                mass1=double(im{mass_ind1}); 
                mass2=double(im{mass_ind2}); 
                %mass2accu=m{7}+m{8};
                mass = double(im{kk});
                all_planes = 1:size(mass,3);
                if length(images)>1
                    if isempty(images{kk})
                        select_planes=all_planes;
                    else
                        select_planes=images{kk};
                    end
                else
                    if isempty(images{1})
                        select_planes=all_planes;
                    else
                        select_planes=images{1};
                    end
                end
                Nplanes=length(all_planes);
                a=zeros(1,Nplanes);
                b=zeros(2,Nplanes);
                for ll=1:Nplanes
                    m1=mass1(:,:,ll);
                    m2=mass2(:,:,ll);
                    mkk =mass(:,:,ll);
                    pix1=m1(ind);
                    pix2=m2(ind);
                    pixkk =mkk(ind);
                    % ----------------------------------------------
                    % this is where the extra condition is specified
                    thr1=0;
                    thr2=10000;
                    %thr2=quantile(mass2accu(ind)/Nplanes,0.999); % this idea didn't give reasonable results                    
                    ind_pix3 = find(pix1>thr1 & pix2<=thr2);                    
                    a(1,ll)=sum(pixkk(ind_pix3));
                    % ----------------------------------------------        
                    ind_pix1 = find(pix1>thr1);
                    ind_pix2 = find(pix2<=thr2);                    
                    b(1,ll)=length(ind_pix1)/length(ind);
                    b(2,ll)=length(ind_pix2)/length(ind);
                    b(3,ll)=length(ind_pix3)/length(ind);
                end
                if 0
                    figure(125);
                    plot(all_planes, b);
                    input('Enter to continue');
                end
                if size(m{1},3)>1
                    rcell(ii,:)=a;
                else
                    rcell(ii)=sum(a(select_planes));
                end
                fprintf(1,'Done.');
                % -------------------------------------
                fprintf(1,'\n');
            end            
            
        end    
        
        
        %f1=figure(60);
        %plot([1:L]',rcell','x-');
        %xlabel('plane'); ylabel(['mass ',num2str(kk)]);

        % fill m{kk} with the accumulated mass in each cell, so that it can be used for
        % ratio calculation
        m_out{kk} = rcell;

        % because of the Poisson statistics, the percentage Poisson error of the mass
        % should be equal to 100%/sqrt(mass), and so the Poisson error should
        % be mass/sqrt(mass)
        warning('off');
        dm{kk} = rcell./sqrt(rcell);
        warning('on');
        
        ind = find(rcell==0);
        dm{kk}(ind) = zeros(size(ind));

    end

    m=m_out;
    
    t2=clock;
    if be_verbous
        fprintf(1,'Counts in all ROIs accumulated in %.2f sec.\n',etime(t2,t1));
    end
    
else
    fprintf(1,'*** Warning: No ROIs defined.\nDefine ROIs or load them from disk before proceeding.\n');
    m=[]; dm=[];
end
