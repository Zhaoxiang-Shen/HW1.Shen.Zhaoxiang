% Static force analysis of for a non minimal tensegrity prism with 3 bars
% 3D
%  By Zhaoxiang Shen, UC San Diego 
clc;clear; clf; figure(1);
%L1= length of a side of bottom triangle
%L2= length of a side of top trangle
%h=distance between two trangles
%theta=angle of two squares  [0,pi/2]
L1=1;L11=L1/3^0.5
L2=1;L22=L2/3^0.5;
h=1;
theta=pi/5;

% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x p)] node locations
Q(:,1)=[0; L11; 0];
Q(:,2)=[L11*cos(pi/6); -L11*sin(pi/6); 0];
Q(:,3)=[-L11*cos(pi/6); -L11*sin(pi/6); 0];
Q(:,4)=[L22*cos(pi*1/2-theta);L22*sin(pi*1/2-theta) ;h]; 
Q(:,5)=[L22*cos(-pi*1/6-theta);L22*sin(-pi*1/6-theta) ;h]; 
Q(:,6)=[L22*cos(-pi*5/6-theta);L22*sin(-pi*5/6-theta) ;h]; 
P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,5)=-1;       % bars 
C(  2,2)=1; C(  2,6)=-1;
C(  3,3)=1; C(  3,4)=-1;b=3;
C(b+1,1)=1; C(b+1,2)=-1;       % strings 
C(b+2,1)=1; C(b+2,4)=-1;    
C(b+3,1)=1; C(b+3,6)=-1;    
C(b+4,2)=1; C(b+4,3)=-1;    
C(b+5,2)=1; C(b+5,4)=-1;    
C(b+6,2)=1; C(b+6,5)=-1;    
C(b+7,3)=1; C(b+7,1)=-1;    
C(b+8,3)=1; C(b+8,5)=-1;    
C(b+9,3)=1; C(b+9,6)=-1;
C(b+10,4)=1; C(b+10,5)=-1;
C(b+11,5)=1; C(b+11,6)=-1;
C(b+12,6)=1; C(b+12,4)=-1;;s=12; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:6)=0;U(3,5)=-1;U(3,6)=-1;U(3,4)=-1;U(3,1)=1;U(3,2)=1;U(3,3)=1

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;

% end script 