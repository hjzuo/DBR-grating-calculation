%一个DBR不加加有源层
function reflect(k1,k2)%参数分别为中心波长、顶部DBR对数、底部DBR对数
L=420;n0=1;ns=3;%金属
Lz1=30;nz1=1.95-0.01i;%ITO
Lz2=5000;nz2=2.49;%GaN
Lz3=4;nz3=2.69;%InGaN阱
Lz4=4;nz4=nz2;%GaN垒
Lz5=209;nz5=nz2;%p-GaN，
Lz6=20;nz6=2.43;%p-AlGaN，
Lz7=2;nz7=2.97;%n-InGaN，
nh=2.1;nl=1.46;
k1=15;k2=12;
dh1=(L/4-1.95*30/2)/nh
L0=350;%画图时波长起始值
step=0.01;%步长
dh=L/(4*nh);%根据中波长和DBR的相位匹配条件计算高低折射率层厚度
dl=L/(4*nl);
for j=1:(500-L0)/step+1%画图j截止值=（画图波长截止值-起始值）/步长
    L1(j)=L0+step*(j-1);%横坐标的每个点
    M=eye(2);
    %传输矩阵中正余弦函数的变量
    x=2*pi*nh*dh/L1(j);
    y=2*pi*nl*dl/L1(j);
    z1=2*pi*nz1*Lz1/L1(j);
    z2=2*pi*nz2*Lz2/L1(j);
    z3=2*pi*nz3*Lz3/L1(j);
    z4=2*pi*nz4*Lz4/L1(j);
    z5=2*pi*nz5*Lz5/L1(j);
    z6=2*pi*nz6*Lz6/L1(j);
    z7=2*pi*nz7*Lz7/L1(j);
    z8=2*pi*nh*dh1/L1(j);%ITO后面的高折射层
         %DBR的总传输矩阵（不含入射层和出射层） 
        M1=[cos(z1),1/nz1*sin(z1)*i;nz1*sin(z1)*i,cos(z1)];%ITO
        M2=[cos(z2),1/nz2*sin(z2)*i;nz2*sin(z2)*i,cos(z2)];%GaN
        M3=[cos(z3),1/nz3*sin(z3)*i;nz3*sin(z3)*i,cos(z3)];%InGaN阱
        M4=[cos(z4),1/nz4*sin(z4)*i;nz4*sin(z4)*i,cos(z4)];%GaN垒
        M5=[cos(z5),1/nz5*sin(z5)*i;nz5*sin(z5)*i,cos(z5)];%p-GaN，
        M6=[cos(z6),1/nz6*sin(z6)*i;nz6*sin(z6)*i,cos(z6)];%p-AlGaN，
        M7=[cos(z7),1/nz7*sin(z7)*i;nz7*sin(z7)*i,cos(z7)];%n-InGaN，
        M8=[cos(z8),1/nh*sin(z8)*i;nh*sin(z8)*i,cos(z8)];%ITO后面的高折射层
        Mh=[cos(x),1/nh*sin(x)*i;nh*sin(x)*i,cos(x)];
        Ml=[cos(y),1/nl*sin(y)*i;nl*sin(y)*i,cos(y)];
        M=M*((Ml*Mh)^k1)*M2*(M3*M4)^5*M6*M5*M7*M1*M8*((Ml*Mh)^k2);%注意各层的顺序
        Ms=M*[1;ns];%出射层即衬底矩阵
        Y=Ms(2)/Ms(1);%导纳
        r(j)=(n0-Y)/(n0+Y);%计算该波长的反射系数
        R(j)=r(j)*conj(r(j));%计算该波长的反射率
        theta(j)=angle((n0-Y)/(n0+Y));
end
figure(1); %画图
subplot(2,2,1);
plot(L1,R,'b');grid on;
xlabel('波长/nm');
ylabel('Reflective index');
hold on ;
subplot(2,2,2);
plot(L1,theta,'r');
xlabel('波长/nm');
ylabel('φ/rad');
A1=([L1;R;theta])';
save data1 A1; %保存数据
hold on ;

    
