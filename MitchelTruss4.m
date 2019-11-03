% Static force analysis of 2D MitchelTruss4
% By Zhaoxiang Shen, UC San Diego 
clc;clear; clf; figure(1);
%theta beta 
%ri = radius
%Ai,Bi = angle operator

theta=pi/16;beta=pi/6;
a=sin(theta+beta)/sin(beta);
r4=1;r3=a*r4;r2=a*r3;r1=a*r2;r0=a*r1;
A1=cos(theta);B1=sin(theta);
A2=cos(theta*2);B2=sin(theta*2);
A3=cos(theta*3);B3=sin(theta*3);
A4=cos(theta*4);B4=sin(theta*4);

% Free [Q=Q_(dim x p)] and fixed [Q=Q_(dim x q)] node locations
Q(:,1)=[r0; 0];
Q(:,2)=[A1*r1; -B1*r1];
Q(:,3)=[A2*r2; -B2*r2];
Q(:,4)=[A3*r3; -B3*r3];
Q(:,5)=[A1*r1; B1*r1]; 
Q(:,6)=[r2; 0]; 
Q(:,7)=[A1*r3; -B1*r3]; 
Q(:,8)=[A2*r2; B2*r2]; 
Q(:,9)=[A1*r3; B1*r3]; 
Q(:,10)=[A3*r3; B3*r3]; 
P(:,1)=[A4*r4; -B4*r4];
P(:,2)=[A2*r4; -B2*r4];
P(:,3)=[r4; 0];
P(:,4)=[A2*r4; B2*r4];
P(:,5)=[A4*r4; B4*r4];

[dim,q]=size(Q), p=size(P,2), n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,2)=-1;       % bars 
C(  2,2)=1; C(  2,3)=-1;    
C(  3,3)=1; C(  3,4)=-1;                                              
C(  4,4)=1; C(  4,11)=-1; 
C(  5,5)=1; C(  5,6)=-1;
C(  6,6)=1; C(  6,7)=-1;
C(  7,7)=1; C(  7,12)=-1;
C(  8,8)=1; C(  8,9)=-1;
C(  9,9)=1; C(  9,13)=-1;
C(  10,10)=1; C(  10,14)=-1;
C(  11,1)=1; C(  11,5)=-1;
C(  12,5)=1; C(  12,8)=-1;
C(  13,8)=1; C(  13,10)=-1;
C(  14,10)=1; C(  14,15)=-1;
C(  15,2)=1; C(  15,6)=-1;
C(  16,6)=1; C(  16,9)=-1;
C(  17,9)=1; C(  17,14)=-1;
C(  18,3)=1; C(  18,7)=-1;
C(  19,7)=1; C(  19,13)=-1;
C(  20,4)=1; C(  20,12)=-1;

b=20;                                           

s=0; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:10)=0; U(2,1)=-1; 

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;

% end script MitchelTruss3