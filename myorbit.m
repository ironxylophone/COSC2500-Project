%change these lines
inter = [0 30];
%x y initial position for mass 1 2 3
ic1 = [0 0 4 4 6 -1];
%x y initial velocity for mass 1 2 3
ic2 = [0 0 0 0 0 0];

%solve and plot
ic = [ic1 ic2];
[t, u] = ode45(@(T,U) ydot(T,U),inter, ic);

figure(1);
vid = VideoWriter('threebod1.avi');
vid.FrameRate = 60;
open(vid);
nextt = 0;
for i = 1:length(u(:,1))
    plot(u(i,1),u(i,2),'ob',...
        u(i,3),u(i,4),'og',...
        u(i,5),u(i,6),'or');
    axis([min([u(:,1);u(:,3);u(:,5)])...
        max([u(:,1);u(:,3);u(:,5)])...
        min([u(:,2);u(:,4);u(:,6)])...
        max([u(:,2);u(:,4);u(:,6)])]);
    title(sprintf('Bodies at t=%f',t(i)));
    xlabel('x');ylabel('y');
    if t(i) >= nextt
        frame = getframe;
        writeVideo(vid,frame);
        nextt = nextt + 1/60;
    end
end
close(vid);

figure(2)
plot(u(:,1),u(:,2),'.b',u(:,3),u(:,4),'.g',...
    u(:,5),u(:,6),'.r');
title("Position of three bodies over time");
xlabel("x");ylabel("y");

figure(3)
plot(t, (u(:,7).^2+u(:,8).^2).^(1/2),t, ...
    (u(:,9).^2+u(:,10).^2).^(1/2),t, ...
    (u(:,11).^2+u(:,12).^2).^(1/2))
title("Velocity of three bodies over time");
xlabel("t");ylabel("v");


function z=ydot(t,x)
%also change these lines
g=1;
m1=1; mg1=m1*g;
m2=1; mg2=m2*g;
m3=1; mg3=m3*g;

px1=x(1);py1=x(2);vx1=x(7);vy1=x(8);
px2=x(3);py2=x(4);vx2=x(9);vy2=x(10);
px3=x(5);py3=x(6);vx3=x(11);vy3=x(12);

dist1=sqrt((px2-px1)^2+(py2-py1)^2);
dist2=sqrt((px3-px1)^2+(py3-py1)^2);
dist3=sqrt((px2-px3)^2+(py2-py3)^2);
z=zeros(12,1);

z(1,1)=vx1;
z(7,1)=(mg2*(px2-px1))/(dist1^3)+(mg3*(px3-px1))/(dist2^3);
z(2,1)=vy1;
z(8,1)=(mg2*(py2-py1))/(dist1^3)+(mg3*(py3-py1))/(dist2^3);

z(3,1)=vx2;
z(9,1)=(mg1*(px1-px2))/(dist1^3)+(mg3*(px3-px2))/(dist3^3);
z(4,1)=vy2;
z(10,1)=(mg1*(py1-py2))/(dist1^3)+(mg3*(py3-py2))/(dist3^3);

z(5,1)=vx3;
z(11,1)=(mg1*(px1-px3))/(dist2^3)+(mg2*(px2-px3))/(dist3^3);
z(6,1)=vy3;
z(12,1)=(mg1*(py1-py3))/(dist2^3)+(mg2*(py2-py3))/(dist3^3);
end
