clc
tic
%主程序：验证球谐函数正�?变换
BNC=16;%[0,BNC]is the range of l in spherical harmonics,that is,(BNC+1)*(BNC+2)/2 is the number of spherical harmonics
N2C=BNC;%BNC;%number of sita[o,pi]
N1=BNC+1;
N3C=2*N2C+1;%2*BNC+1;%N3C is the numer of phi [0,2*pi]
YPlm=prepare(N1,BNC,N3C,N2C);
qq=zeros(N2C,N3C);
gauss=get_gaussian(N2C);
 theta=acos(gauss(:,1));
 phi=(2*pi/(N3C)*(0:N3C-1))';
cossita=zeros(N2C,1);sinsita=zeros(N2C,1);%cosphi=zeros(N3C,1);sinphi=zeros(N3C,1);
r=1;
for i=1:N2C
    if i<=(N2C+1)/2
        cossita(i)=gauss(i,1);
    else
        cossita(i)=-gauss(N2C+1-i,1);
    end
    sinsita(i)=sqrt(1-cossita(i)*cossita(i));
end
   
    cosphi=cos(2*pi/(N3C)*(0:N3C-1))';
	sinphi=sin(2*pi/(N3C)*(0:N3C-1))';


  qq=sinsita*cosphi';%给定的球谐函数g(sita,phi)
  
  
%   for i=1:N2C
%      for j=1:N3C
%          %qq(i,j)=cos(2*(sinsita(i)*cosphi(j)+sinsita(i)*sinphi(j)+cossita(i)));
%          %qq(i,j)=sin((asin(sinsita(i))+phi(j)));
%          %qq(i,j)=sin(r*(sinsita(i)*cosphi(j)))*sin(r*((sinsita(i)*sinphi(j))))*sin(r*(cossita(i)));
%      end
%   end
        %qq=cossita;%给定的球谐函数g(sita,phi)
           %qq(i,j)=sin((asin(sinsita(i))+phi(j)));
    
qy=real2spherical_r2c(N1,N3C,BNC,N2C,qq,YPlm);%固定sita,对球谐函数g(sita,phi)傅里叶变换，g(lm)
qq1=spherical2real_c2r(N1,N3C,BNC,N2C,qy,YPlm);%固定sita,对球谐函数g(sita,phi)逆傅里叶变换，g(sita,phi)*
%disp(qy)
disp(qq1-qq);%球谐函数正�?变换误差
%plot(qq)
%for i=1:N2C
%	fprintf('%6.9f\n',gauss(i,1));
%end
toc