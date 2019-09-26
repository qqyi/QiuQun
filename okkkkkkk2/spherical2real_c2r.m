%通过IFFT求g(sita,phi)*
function qB0=spherical2real_c2r(N1,N3C,BNC,N2C,qy,YPlm)	
complex=zeros(2,N3C);
c=zeros(1,BNC+1);
qB0=zeros(N2C,N3C);
%[YPlm,Y_star]=prepare(N1,BNC,N3C,N2C);%调用除e^(im*phi)外的Y_lm(sita,phi),即h(sita)
for i=1:N2C
    for m=1:BNC+1
         complex(1,m)=0;
         complex(2,m)=0;
         l=BNC+1;
         while l>=m
             temp1=YPlm(((l-1)*l/2+m),i);
             p=qy(l,m);
             
             complex(1,m)=complex(1,m)+real(p)*temp1;
             
             complex(2,m)=complex(2,m)+imag(p)*temp1;
           l=l-1;
         end        
           c(m)=funxushu(complex(1,m),complex(2,m));  %求m>=0时逆傅里叶（IFFT）系数
       
    end 

    for m=BNC+2:N3C        
         l=BNC+1;
         mm=N3C+2-m;
         complex(1,m)=0;
         complex(2,m)=0;
         while l>=mm
             temp1=power(-1,mm)*YPlm((l-1)*l/2+mm,i);
             p=qy(l,m);   
             complex(1,m)=complex(1,m)+real(p)*(temp1);
              %fprintf('%.9f\t',complex(1,m));
              complex(2,m)=complex(2,m)+imag(p)*(temp1);
            
                 
           l=l-1;
         end        
           c(m)=funxushu(complex(1,m),complex(2,m));  %求m>=0时逆傅里叶（IFFT）系数
           %fprintf('\n');
    end 
    %fprintf('%.9f\t',c)
    real_t=ifftn(c)*(N3C);%通过IFFT求g(sita,phi)*
    for j=1:N3C
        qB0(i,j)=real_t(j);
    end
   
    
end


              
        
            

             
				
			        
         
			
			
