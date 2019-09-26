n=1024;m=n;
h=1e-1;T=100;
u0=@(x,y,z)cos(40*x)+cos(40*y)+cos(40*z);
th=pi/8;c=cos(th);s=sin(th);
u0=1/3*spherefun(@(x,y,z)u0(c*x-s*z,y,s*x+c*z))
v0=reshape(coeffs2(u0,m,n),m*n,1)