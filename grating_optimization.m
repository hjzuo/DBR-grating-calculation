clear all;
wavelength=1000:1:2000;wavelength_center=1550;
N_period=200;
grating_index=2.54236;cladding_index=2.44468;
% grating_period=(wavelength_center/grating_index)*0.25+(wavelength_center/cladding_index)*0.25;
grating_period=320;
% duty_cycle=cladding_index/(cladding_index+grating_index);
duty_cycle=0.5;
r=zeros(1,length(wavelength));          % reflection from grating
Grating=structure(grating_index,cladding_index,grating_period,N_period,duty_cycle);

for i=1:length(wavelength)
    temp=jreftran_rt(wavelength(i),Grating.length,Grating.index,0,0);
    r(i)=temp.R;
    t(i)=temp.T;
end
% bar(S.length)
% figure
% bar(S.index);
% figure
plot(wavelength,r);
% hold on;plot(wavelength,t);