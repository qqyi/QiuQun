clc
n=64;
gauss=get_gaussian(n);
x=gauss(:,1);
w=gauss(:,2);
theta=acos(x);
thetan=length(theta);
phin=thetan-1;
phi=(2*pi/(phin+1)*(0:phin))';
r=ones(phin+1,1);
[mu,xi,eta]=sph2cart(theta,phi,r);
% M = 20;
% s = FEMAngularGrid(M);
% mu = s.ang(:,1);
% xi = s.ang(:,2);
% eta = s.ang(:,3);
%plot3(mu,xi,eta)


% g = 0.5;
%f = HG3D(mu, g);
%phi=zeros(phin,1);
f=zeros(thetan,phin);
for i=1:thetan
    for j=1:phin
      f(i,j)=sin(1*(theta(i)+phi(j)));
      %f(i,j)=sin(theta(i))*sin(phi(j));
    end
end
 %f=ones(phin,1);
MaxL = 5;
coe = zeros((MaxL+1)^2,1);
fr = zeros(size(f));
for i=1:thetan
   for l = 0 : MaxL
      for m = -l : l 
        y = SphericalHarmonicBasis(mu, xi, eta, l, m);
        a=1/sqrt(pi)*NormalizedAssociatedLegendrePolynomails(l, m, eta(i))
        b=f(i,:).*w(i);
        %a=conj(y).*y;
        coe(ilm(l,m)) =a.*b;%系数
        
        fr(i,:) = fr(i,:) + (coe(ilm(l,m))*y)';
      end
   end
 end
%fr=fr.*exp(-6);
%   x = 1 : numel(f);
%   plot(x, f, x, fr);
x=sin(theta)*cos(phi)';
y=sin(theta)*sin(phi)';
z=cos(theta)*ones(1,phin);
 d=norm(f-fr,inf)
figure(1)
surf(x,y,z,f)
shading interp;%light;lighting gouraud;

colorbar

axis equal;

xlabel('x');ylabel('y');zlabel('z');
