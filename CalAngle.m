function [theta, phy] = CalAngle(treedata,row)

vector = treedata(row,1:3) - treedata(row-1,1:3);

x = vector(1,1);
y = vector(1,2);
z = vector(1,3);
l = sqrt(x^2+y^2+z^2);
theta = atan2(y,x);
phy = acos(z/l);

% phyt = subspace(vector',[0 0 1]');
% if z>=0
%     phy = phyt*180/pi;
% elseif z <0
%     phy = pi - phyt*180/pi;
% end
% thetat = subspace(vector',[1 0 0]');
% if x >=0 && y>=0
%     theta = thetat*180/pi;
% elseif x<0 && y>=0
%     theta = 180 - thetat*180/pi;
% elseif x<0 && y<0
%     theta = 180 + thetat*180/pi;
% elseif x>=0 && y < 0
%     theta = -thetat*180/pi;
% end

% coss = x/(sqrt(x^2+y^2));
% theta = acos(coss);
% if y >= 0
%     theta = theta*180/pi;
% else
%     theta = 360 - theta*180/pi;
% end
% tant = (sqrt(x^2+y^2))/abs(z);
% if z >=0
%     phy = atan(tant)*180/pi;
% else
%     phy = pi - atan(tant)*180/pi;
% end