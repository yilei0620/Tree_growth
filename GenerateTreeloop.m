clear

lamuda = [0.52 0.48];
aaa = [10 8]; %??????????????
Mlevels = 12; %????level
%??????year????????????trunk??%
year = 0;
maxyear = 0;
%??????year????????????trunk??%

Maxyear = 20; %????????

%%????Trunk
%%????
BmaxAngle =38/180*pi;%2??????????????????????????
%????
maxnodes = [5 3]; %????????????
N = 1;%??????
root1 = [3 2 0]; %??????????
root2 = [4.5 2 0];

% root3 = [5.15 5.3 0]; %??????????
% root4 = [3 7 0];
% root5 = [7 3 0]; %??????????
% root6 = [0.1 0.2 0];
% root7 = [0.2 0.2 0];

root = [];
%????????obj????%
for i = 1:N
    eval(['root = [root;root',num2str(i),'];']);
    filename = strcat('Treedata',num2str(i));
    filename = strcat(filename,'.obj');
    filename1{i} = filename;
end
%????????obj????%

Tradius = 0.015; %????????
 %????trunk??internode????
 
Tlength = 0.1;
%????????????????????????xy????????
Ttheta = [0 0 0];%????????X????????????xy??????????????
Tphy = [0/180*pi 0/180*pi 0/180*pi];%??????Z??????

%% ????????????????????????
lengthmax = [-4 11];
widthmax = [-4 8];
heightmax = [-1 10];
chang = round((lengthmax(2) - lengthmax(1))/(Tlength/2));
kuan = round((widthmax(2) - widthmax(1))/(Tlength/2));
gao = round((heightmax(2) - heightmax(1))/(Tlength/2));
jishuge = zeros(chang,kuan,gao)+1;
% ????????????????????????????
% jishuge(161:200,161:200,121:160) = 0;
% for i = 0:19
%     jishuge(161+i:200-i,161+i:200-i,120-2*i-1:120-2*i) = 0.2;
% end
% jishuge(161:200,161:200,1:120) =jishuge(161:200,161:200,1:120)-0.15;
% jishuge(151:210,151:210,121:160) = jishuge(151:210,151:210,121:160) - 0.7;


%  jishuge(81:180,1:280,121:130) = 0;
%  for i = 0:99
%      jishuge(81:81+i,1:280,21+i) = 0.4;
%      jishuge(81+i:81+i+5,1:280,21+i) = 0.6;
%      jishuge(81+i+6:81+i+11,1:280,21+i) = 0.8;
%  end
%  jishuge(181:185,1:280,121:130) = jishuge(181:185,1:280,121:130)-0.7;

%% ??????????????

Ltheta = rand(N,1)*2*pi - pi;
NodeNo = zeros(N,1);
for i = 1:N
    jishuge((root(i,1)+4)*20+1,(root(i,2)+4)*20+1,21) = 0;
    randP1 = GenRandPtuoyuan(0.2,0.2,1,5);
    randP1(:,1) = randP1(:,1) + root(i,1);
    randP1(:,2) = randP1(:,2) + root(i,2);
    randP1(:,3) = randP1(:,3) + 1;
    
    fp = fopen(filename1{i},'w');
    fclose(fp);
    [level, year, Ttheta(i), Tphy(i), BranchNo, NodeNo1, jishuge,  Ltheta1,randP1] = GenTree4(root(i,:),1,...
        maxnodes(i),Tradius,Tlength,Ttheta(i),Tphy(i),year,filename1{i},1,1,1,jishuge,0,Ltheta(i,1),randP1);
    NodeNo(i) = NodeNo1;
    Ltheta(i,1) = Ltheta1;
end
%% ????????????
year = maxyear;
 [year, NodeNo,jishuge]= TreeGrow2(Mlevels,BmaxAngle,year,Maxyear,filename1,NodeNo,jishuge,Ltheta,lamuda,aaa);

%% ????????????????????obj????
fp = fopen('TreedataF.obj','w');
for i = 1:N
        fid = fopen(filename1{i},'r');
        n = 1;
        while 1
                    tline = fgetl(fid);
                    if ~ischar(tline), break, end
                    fprintf(fp,'%s',tline); 
                    fprintf(fp,'\r\n'); 
                    n=n+1;
        end
        fclose(fid);
        

end
fclose(fp);


