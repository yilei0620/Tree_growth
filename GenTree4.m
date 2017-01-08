function [level year Rtheta Rphy BranchNo NodeNo jishuge  Ltheta,randP] = GenTree4(root,level,NodeNum,...
    radius,length,theta,phy,year,filename,BranchNo,NodeNo,RootNo,jishuge,yuanzhi,Ltheta,randP)
    %返回本树枝初始角度
    Rtheta = theta;
    Rphy = phy; 
    %
    %初始节点的记录
    BranchNo = BranchNo + 1;
    Mnodes = zeros(NodeNum,5);
    Mnodes(1,1:3) = root ;
    Mnodes(1,4) = radius;
    Mnodes(1,5) = RootNo;
    Mangle = zeros(NodeNum,2);
    Mangle(1,:) = [theta phy];
    MNodeNo = NodeNo;
    %
    for i = 1:NodeNum-1
        %% 伸展方向，单独定义函数更好
        if i==1
            jishux = floor(Mnodes(1,1) * 20) + 81;
            jishuy = floor(Mnodes(1,2) * 20) + 81;
            jishuz = floor(Mnodes(1,3) * 20) + 21;
            jishuge(jishux,jishuy,jishuz) = jishuge(jishux,jishuy,jishuz) + 1;
            [theta,~,nodex,nodey,nodez,NodeNum,test2,randP] = nextnode2(Mnodes,i,length,theta,phy,level,NodeNum,jishuge,year,randP);
            jishuge(jishux,jishuy,jishuz) = jishuge(jishux,jishuy,jishuz) - 1;
        else
            [theta,~,nodex,nodey,nodez,NodeNum,test2,randP] = nextnode2(Mnodes,i,length,theta,phy,level,NodeNum,jishuge,year,randP);
        end
        if test2 == 0
            break
        end
        %计数格，单独定义函数
        [NodeNum, jishuge, test] = Qjishu(i,NodeNum,nodex,nodey,nodez,jishuge);
      
        if test == 0
            break
        end
        
        MNodeNo = MNodeNo + 1;
        Mnodes(i+1,:) = [nodex nodey nodez radius MNodeNo];
        
        direction2 = Mnodes(i+1,1:3) - Mnodes(i,1:3);
        direction2 = direction2/norm(direction2);
        phy = subspace([0 0 1]',direction2');
        
        if direction2(3) < 0
            phy = pi -  phy;
        end

        Mangle(i+1,:) = [theta phy];
        %%
    end
    for i =2 : NodeNum 
        nodex =Mnodes(i,1);
        nodey =Mnodes(i,2);
        nodez =Mnodes(i,3);
        
        jishuge = Qjishu2(nodex,nodey,nodez,jishuge,year,1);
    end
    %% 生成图形及数据记录

    if NodeNum < 2 && level == 2
         Rtheta = Rtheta - 135/180*pi;
     
        return
    elseif NodeNum < 2
        return
    end
    
    fp = fopen(filename,'a');
    if yuanzhi ~=1
        fprintf(fp,'%s','g Branch ');
        fprintf(fp,'%d',BranchNo-1);
        fprintf(fp,'\r\n');
        fprintf(fp,'%s %d %d %d %d %d %d %d','v',Mnodes(1,1),Mnodes(1,2),Mnodes(1,3),Mnodes(1,4),level,year,RootNo);
        fprintf(fp,'\r\n');
    end
    
    for i =1:NodeNum-1
        NodeNo = NodeNo + 1;
        fprintf(fp,'%s %d %d %d %d %d %d %d','v',Mnodes(i+1,1),Mnodes(i+1,2),Mnodes(i+1,3),Mnodes(i+1,4),level,year,NodeNo);
        fprintf(fp,'\r\n');
    end
    fclose(fp);
