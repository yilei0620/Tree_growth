function [thetatemp panduan]= LbiAngleCal(phy,LbiAngle)
if abs(phy) >1*pi/180
    thetatemp = atan2(tan(LbiAngle*pi/180),sin(phy));
    panduan = 0;
else
    thetatemp = pi/2;
    panduan = 1;
end

