function y=trapstep(t,x1,x2,x3,h)
%one step of the Trapezoid Method
z1=ydot(t,x1,x2,x3);
g1=x1+h*z1(1:4);g2=x2+h*z1(5:8);g3=x3+h*z1(9:12);
z2=ydot(t+h,g1,g2,g3);
y=[x1 x2 x3]+h*(z1+z2)/2;