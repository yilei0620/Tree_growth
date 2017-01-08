function [level, year, BranchNo, NodeNo, jishuge, Ltheta, treedata, I] = GenTree7(BmaxAngle,year,BranchNo,NodeNo,jishuge,Ltheta,treedata,BnodeI,I,randP,NNN)

sizeB = size(BnodeI);
if NNN ==1
    a = 100;
elseif NNN ==2
    a = 70;
end
b = 0.34;
c = 3;
xianzhi = Logisticjudge(year,a,b,c);
for j = 1 : sizeB(2)
    Broot = treedata(BnodeI(1,j),1:7);
    Brootpri = treedata(BnodeI(1,j)-1,1:3);
    level = Broot(1,5)+1;
    shuzhi = BnodeI(3,j);
    Blength = BnodeI(2,j)/( floor(BnodeI(2,j))*10);
    randP2 = ChooserandP(Broot,xianzhi,Blength,randP,Brootpri);
    quchudian = [];
    if level == 2 %因为2级枝影响比较大，所以单独定义（可以通过更全面的几何方法优化这部分是的其分支方式与其他侧枝一样）
        Branchnum = floor(BnodeI(2,j));
        RootNo = Broot(1,7);
        %% 叶序设置
        if treedata(BnodeI(1,j)+1,7) ==0
            if Branchnum > 4
                   Branchnum = 4 ;
            end
        else
            if Branchnum > 3
                   Branchnum = 3;
            end
        end
        Bmaxnodes = round(BnodeI(2,j)/(Branchnum))+1;
        if Bmaxnodes > round(xianzhi)
            Bmaxnodes = round(xianzhi);
        end
        if Bmaxnodes < 2
            continue
        end
        %% 生长
        zhibiao1 = 0;
        for m = 1:Branchnum
                Bradius = 0.003;
                if treedata(BnodeI(1,j)+1,7) ==0 && m ==1
                    [Btheta1, Bphy1]= CalAngle(treedata,BnodeI(1,j)); % 分枝角度函数
                    level = level - 1;
                    Broot = Broot(1:3);
                    [level, year,  BranchNo, NodeNo, jishuge, Ltheta, treedata, I,BnodeI,quchuP,randP2] = GenTree8(Broot,level,...
                         Bmaxnodes,Bradius,Blength,Btheta1,Bphy1,year,BranchNo,NodeNo,RootNo,jishuge,1,Ltheta,treedata,I,BnodeI,j,shuzhi,randP2,NNN);
                    level = level + 1;
                    zhibiao1 = 1;
                else
                    if zhibiao1 ==0 && m == 4
                        break
                    end
                    [~, Bphy]= CalAngle(treedata,BnodeI(1,j));
                    Bphy = BmaxAngle + Bphy;
                    Btheta = Ltheta + 135*pi/180; %problem
                    Broot = Broot(1:3);
                   [level, year,  BranchNo, NodeNo, jishuge, ~, treedata, I,BnodeI,quchuP,randP2] = GenTree8(Broot,level,...
                         Bmaxnodes,Bradius,Blength,Btheta,Bphy,year,BranchNo,NodeNo,RootNo,jishuge,0,Ltheta,treedata,I,BnodeI,j,shuzhi,randP2,NNN);
                     Ltheta = Btheta;
                end

                quchudian = [quchudian quchuP];

        end
    elseif level > 2
        %% 生长
        Branchnum = floor(BnodeI(2,j));
        RootNo = Broot(1,7);
        
        
        if treedata(BnodeI(1,j)+1,7) ==0
            if Branchnum > 3
                   Branchnum = 3 ;
            end
        else
            if Branchnum > 2
                   Branchnum = 2;
            end
        end
        Bmaxnodes = floor(BnodeI(2,j)/(Branchnum))+1;
        if Bmaxnodes > round(xianzhi)
            Bmaxnodes = round(xianzhi);
        end
        if Bmaxnodes < 2
            continue
        end
        if rand > 0.5
                fangxiangj = 1;
        else
                fangxiangj = 2;
        end
        
        zhibiao1 = 0;
            for m = 1:Branchnum
                Bradius = 0.003;
                if treedata(BnodeI(1,j)+1,7) ==0 && m ==1 
                    [Btheta1, Bphy1]= CalAngle(treedata,BnodeI(1,j));
                    level = level - 1;
                    Broot = Broot(1:3);
                    [level, year,  BranchNo, NodeNo, jishuge, Ltheta, treedata, I,BnodeI,quchuP,randP2] = GenTree8(Broot,level,...
                         Bmaxnodes,Bradius,Blength,Btheta1,Bphy1,year,BranchNo,NodeNo,RootNo,jishuge,1,Ltheta,treedata,I,BnodeI,j,shuzhi,randP2,NNN); 
                    level = level + 1;
                    zhibiao1 = 1;
                else
                    if zhibiao1 ==0 && m ==3
                        break
                    end
                    [Btheta, Bphy]= CalAngle(treedata,BnodeI(1,j)); %problem
                    [thetatemp, panduan]= LbiAngleCal(Bphy,45);
                    if panduan == 0
                        Btheta = Btheta + (-1)^(fangxiangj)*thetatemp;
                    elseif panduan ==1
                        Btheta = Btheta + (-1)^(fangxiangj)*thetatemp;
                        Bphy = Bphy + 45*pi/180;
                    end
                    Broot = Broot(1:3);
                   [level, year,  BranchNo, NodeNo, jishuge, Ltheta, treedata, I,BnodeI,quchuP,randP2] = GenTree8(Broot,level,...
                        Bmaxnodes,Bradius,Blength,Btheta,Bphy,year,BranchNo,NodeNo,RootNo,jishuge,0,Ltheta,treedata,I,BnodeI,j,shuzhi,randP2,NNN);
                   fangxiangj = fangxiangj + 1;
                end
                quchudian = [quchudian quchuP];

            end
    end
    %% quchudian中记录的是该发芽点发芽过后，在点云集中需要删掉的点云（此处可优化提高速度）
%                 quchudian = sort(quchudian);
%                 sizeP = size(quchudian);
%                 kk = sizeP(2);
                randP_temp = randP.X;
                size_randp = size(randP_temp);
                temp_quchu = ones(size_randp(1),1);
                temp_quchu = logical(temp_quchu);
                temp_quchu(quchudian) = 0;
                randP_temp = randP_temp(temp_quchu,:);
                randP = KDTreeSearcher(randP_temp);
%                 while 1
%                     if kk < 1
%                         break
%                     end
%                     randP(quchudian(kk),:) = [];
%                     kk = kk - 1;
%                 end
end