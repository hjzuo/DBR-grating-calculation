function out=structure(n_g,n_c,g_p,N_p,duty)

index_grating=n_g;
index_cladding=n_c;
index_air=1;
grating_period=g_p;Nperiod=N_p;
duty_cycle=duty;
Nlayer=grating_period*2+2;          % layer complex refractive index vector
M=zeros(1,Nperiod*2+2);
M(1)=1;M(length(M))=1;
for i=2:length(M)-1
    if(mod(i,2)==0)
        M(i)=index_grating;
    else
        M(i)=index_cladding;
    end
end

L=zeros(1,Nperiod*2+2);      % layer thickness vector, nm
L(1)=NaN;L(length(L))=NaN;
for i=2:length(M)-1
    if(mod(i,2)==0)
        L(i)=grating_period*duty_cycle;
    else
        L(i)=grating_period*(1-duty_cycle);
    end
end
out.index=M;
out.length=L;
end