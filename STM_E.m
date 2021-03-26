%% Sample Code for STM-E
%% LOAD DATA

clear all
load SampleData.mat

[rknum, evnum]=size(DataHs); % storm events from original data 
evrate=0.62; %0.62=events per year
lnum=31; % location of interest

%% Problem Setting for T0=200 years data

ynum=200; % T0=period of sample data
estnum=500; % T1=period to estimate return value
dnum=ynum*evrate; % n0=data size of sample (before extraction)
dnum1=estnum*evrate;  % data size for return period

sn=[20 30 40 50 60]; % n=number of data to extract from whole sample
snum=length(sn);

%% Random Permutation for "cnum" cases  
cnum=100;

for ci=1:cnum % cnum random cases for Single loc & STM-E
    
    % Choose dnum events
    tcrand=randsample(evnum,dnum); % random select dnum events

    for ni=1:snum % F
    XX=sn(ni);
    Enum=XX/ynum*estnum;

% Single location: Estimate GP for snum events per ynum years with MLE

for rki=1:lnum
    Hstemp=sort(DataHs(rki,tcrand),'descend'); % 
    Hs_ext=Hstemp(1:XX); % Use top XX out of dnum
    Hs_thr=Hstemp(XX)-0.1; % Set threshold just below
    [phat cov]=gpfit(Hs_ext-Hs_thr); % Estimate GP with MLE
    Est_loc(ni,rki,ci)=gpinv(1-1/Enum, phat(1), phat(2))+Hs_thr; % Estimate 500 year RV
end % end loop for single location %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% STM-E: Estimate STM & Exposure for snum events per ynum years with MLE 

clear Scdf Spdf SEval SEpdf

STM=max(DataHs(:,tcrand)); % STM for selected region (size dnum)
STMtemp=sort(STM,'descend');
STM_thr=STMtemp(XX)-0.1;

tcx=find(STM>=STM_thr);
tcxnum=length(tcx);

clear STM_Hs Exp_Hs

STM_Hs=STM(tcx); % STM_Hs: largest XX
Exp_Hs=DataHs(1:lnum,tcrand(tcx))./STM(tcx); % Exposure for largest XX

% STM (GPD / ML)
[phat cov]=gpfit(STM_Hs-STM_thr);

xx=STM_thr:0.1:80;
xn=length(xx); % STM mesh

Scdf=wgpdcdf(xx-STM_thr,phat(1),phat(2));
Spdf=wgpdpdf(xx-STM_thr,phat(1),phat(2));
Spdf=Spdf/sum(Spdf); % Adjust pdf

% Apply STM-E
y=0:0.01:1; % Exposure mesh
yn=length(y);

for ai=1:xn
    for bi=1:yn
        SEval(ai,bi)=xx(ai)*y(bi); % Mesh corresponding to combination of STM and Exposure
    end
end

% FOR each grid calculate Exposure & STM-E
for rki=1:lnum  
    
    Etemp=Exp_Hs(rki,:); % Define pdf of Exposure from CDF
        for yyi=1:yn
            Ecdf(yyi)=length(find(Etemp<=y(yyi)))/tcxnum;% Ecdf : empirical exposure CDF
            if yyi==1
                Epdf(yyi)=Ecdf(yyi); % Epdf : empirical exposure PDF
            else
                Epdf(yyi)=Ecdf(yyi)-Ecdf(yyi-1);    
            end    
        end
                
% Define Joint pdf from Spdf x Epdf
    for ai=1:xn
        for bi=1:yn
            SEpdf(ai,bi)=Spdf(ai)*Epdf(bi);
        end
    end

% Define CDF from joint pdf 
    xD=0:0.1:50; % set mesh for SEcdf
    xnum=length(xD);
    SEcdf(1:xnum)=0; % SEcdf = CDF for STM-E

    for hi=1:xnum
        clear kk
        kk=find(SEval<=xD(hi));
        SEcdf(hi)=sum(SEpdf(kk));
    end

% Estimate RV for Enum
    ks=[];
    ks=find(SEcdf > 1-1/(Enum),1); % Return Period from Fevent
    Est_stm(ni,rki,ci)=xD(ks);

end % end loop for location 

    end % end loop for ni 

end % end loop for cnum case

% True Value from resampling

for ci=1:cnum
    tcrand1=randsample(evnum,dnum1);
    for li=1:lnum
        Xtru(li,ci)=max(DataHs(li,tcrand1));
    end
end