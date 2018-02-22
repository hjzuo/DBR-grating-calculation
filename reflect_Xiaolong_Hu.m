%һ��DBR���Ӽ���Դ��
function reflect(k1,k2)%�����ֱ�Ϊ���Ĳ���������DBR�������ײ�DBR����
L=420;n0=1;ns=3;%����
Lz1=30;nz1=1.95-0.01i;%ITO
Lz2=5000;nz2=2.49;%GaN
Lz3=4;nz3=2.69;%InGaN��
Lz4=4;nz4=nz2;%GaN��
Lz5=209;nz5=nz2;%p-GaN��
Lz6=20;nz6=2.43;%p-AlGaN��
Lz7=2;nz7=2.97;%n-InGaN��
nh=2.1;nl=1.46;
k1=15;k2=12;
dh1=(L/4-1.95*30/2)/nh
L0=350;%��ͼʱ������ʼֵ
step=0.01;%����
dh=L/(4*nh);%�����в�����DBR����λƥ����������ߵ������ʲ���
dl=L/(4*nl);
for j=1:(500-L0)/step+1%��ͼj��ֵֹ=����ͼ������ֵֹ-��ʼֵ��/����
    L1(j)=L0+step*(j-1);%�������ÿ����
    M=eye(2);
    %��������������Һ����ı���
    x=2*pi*nh*dh/L1(j);
    y=2*pi*nl*dl/L1(j);
    z1=2*pi*nz1*Lz1/L1(j);
    z2=2*pi*nz2*Lz2/L1(j);
    z3=2*pi*nz3*Lz3/L1(j);
    z4=2*pi*nz4*Lz4/L1(j);
    z5=2*pi*nz5*Lz5/L1(j);
    z6=2*pi*nz6*Lz6/L1(j);
    z7=2*pi*nz7*Lz7/L1(j);
    z8=2*pi*nh*dh1/L1(j);%ITO����ĸ������
         %DBR���ܴ�����󣨲��������ͳ���㣩 
        M1=[cos(z1),1/nz1*sin(z1)*i;nz1*sin(z1)*i,cos(z1)];%ITO
        M2=[cos(z2),1/nz2*sin(z2)*i;nz2*sin(z2)*i,cos(z2)];%GaN
        M3=[cos(z3),1/nz3*sin(z3)*i;nz3*sin(z3)*i,cos(z3)];%InGaN��
        M4=[cos(z4),1/nz4*sin(z4)*i;nz4*sin(z4)*i,cos(z4)];%GaN��
        M5=[cos(z5),1/nz5*sin(z5)*i;nz5*sin(z5)*i,cos(z5)];%p-GaN��
        M6=[cos(z6),1/nz6*sin(z6)*i;nz6*sin(z6)*i,cos(z6)];%p-AlGaN��
        M7=[cos(z7),1/nz7*sin(z7)*i;nz7*sin(z7)*i,cos(z7)];%n-InGaN��
        M8=[cos(z8),1/nh*sin(z8)*i;nh*sin(z8)*i,cos(z8)];%ITO����ĸ������
        Mh=[cos(x),1/nh*sin(x)*i;nh*sin(x)*i,cos(x)];
        Ml=[cos(y),1/nl*sin(y)*i;nl*sin(y)*i,cos(y)];
        M=M*((Ml*Mh)^k1)*M2*(M3*M4)^5*M6*M5*M7*M1*M8*((Ml*Mh)^k2);%ע������˳��
        Ms=M*[1;ns];%����㼴�ĵ׾���
        Y=Ms(2)/Ms(1);%����
        r(j)=(n0-Y)/(n0+Y);%����ò����ķ���ϵ��
        R(j)=r(j)*conj(r(j));%����ò����ķ�����
        theta(j)=angle((n0-Y)/(n0+Y));
end
figure(1); %��ͼ
subplot(2,2,1);
plot(L1,R,'b');grid on;
xlabel('����/nm');
ylabel('Reflective index');
hold on ;
subplot(2,2,2);
plot(L1,theta,'r');
xlabel('����/nm');
ylabel('��/rad');
A1=([L1;R;theta])';
save data1 A1; %��������
hold on ;

    
