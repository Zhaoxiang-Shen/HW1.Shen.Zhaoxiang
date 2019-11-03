% Static force analysis of for a non minimal tensegrity prism with 4 bars
% 3D
%  By Zhaoxiang Shen, UC San Diego 
clc;clear; clf; figure(1);
%L1=1/2 length of a side of bottom square
%L2=1/2 length of a side of top square
%h=distance between two squares 
%theta=angle of two squares  [0,pi/4]
L1=2;
L2=1;L22=L2*2^0.5;
h=2;
theta=pi/5;

% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x p)] node locations
Q(:,1)=[-L1; L1; 0];
Q(:,2)=[L1; L1; 0];
Q(:,3)=[L1; -L1; 0];
Q(:,4)=[-L1; -L1; 0];
Q(:,5)=[L22*cos(pi*3/4-theta);L22*sin(pi*3/4-theta) ;h]; 
Q(:,6)=[L22*cos(pi*1/4-theta);L22*sin(pi*1/4-theta) ;h]; 
Q(:,7)=[L22*cos(-pi*1/4-theta);L22*sin(-pi*1/4-theta) ;h]; 
Q(:,8)=[L22*cos(-pi*3/4-theta);L22*sin(-pi*3/4-theta) ;h]; 
P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,7)=-1;       % bars 
C(  2,2)=1; C(  2,8)=-1;
C(  3,3)=1; C(  3,5)=-1;
C(  4,4)=1; C(  4,6)=-1;b=4;
C(b+1,1)=1; C(b+1,2)=-1;       % strings 
C(b+2,1)=1; C(b+2,5)=-1;    
C(b+3,1)=1; C(b+3,8)=-1;    
C(b+4,2)=1; C(b+4,3)=-1;    
C(b+5,2)=1; C(b+5,5)=-1;    
C(b+6,2)=1; C(b+6,6)=-1;    
C(b+7,3)=1; C(b+7,4)=-1;    
C(b+8,3)=1; C(b+8,6)=-1;    
C(b+9,3)=1; C(b+9,7)=-1;
C(b+10,4)=1; C(b+10,1)=-1;
C(b+11,4)=1; C(b+11,7)=-1;
C(b+12,4)=1; C(b+12,8)=-1;
C(b+13,5)=1; C(b+13,6)=-1;
C(b+14,6)=1; C(b+14,7)=-1;
C(b+15,7)=1; C(b+15,8)=-1;
C(b+16,8)=1; C(b+16,5)=-1;s=16; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:8)=0;U(3,5)=1;U(3,6)=1;U(3,7)=1;U(3,8)=1;U(3,1)=-1;U(3,2)=-1;U(3,3)=-1;U(3,4)=-1;

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;

% end script 