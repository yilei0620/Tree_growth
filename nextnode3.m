function [theta,phy,nodex,nodey,nodez,NodeNum,test2,randP2,quchuP] = nextnode3(Mnodes,i,length,theta,phy,level,NodeNum,jishuge,year,randP2,NNN)
        test2 = 1;
        quchuP = [];
        maxyear = 25;
        rrr = rand*2-1;
        lengthi = length ;
        phyt = phy; 
        nodez = Mnodes(i,3) + cos(phy)*lengthi;
        nodex = Mnodes(i,1) + sin(abs(phy))*lengthi*cos(theta);
        nodey = Mnodes(i,2) + sin(abs(phy))*lengthi*sin(theta);
        if year <=16
        w1 = 1;
        w2 = -0.5;
        elseif year > 16 && NNN ==1
            w1 = 1;
            w2 = 8;
        elseif year > 16 && NNN ==2
            w1 = 1;
            w2 = -0.5;
        end
        if isempty(randP2)
            test2 = 0;
            NodeNum = i;
            return
        end
        if nodez < 0.2 && level >=2
            test2 = 0;
            NodeNum = i;
            return
        end
        Ddirection = [nodex nodey nodez] - Mnodes(i,1:3);
        j = 1;
        Omarker = [];
        
        while 1
           
            marker = randP2(j,1:3);
            if norm(Mnodes(i,1:3)-marker) <= 2 * length
                quchuP = [quchuP randP2(j,4)];
                randP2(j,:) = [];
                j = j-1;
                
            end
            Odirection = marker - Mnodes(i,1:3);
            jiaodu = sum(Odirection .* Ddirection)/(norm(Odirection)*norm(Ddirection));
            jiaodu = acos(jiaodu)*180/pi;
            
            if jiaodu <= 30 && norm(Mnodes(i,1:3)-marker) <= 4*length
                Omarker = [Omarker;marker];
            end
             sizeRP = size(randP2);
            j = j+1;
            if j == sizeRP(1) + 1
                break
            end
        end
        if isempty(Omarker)
            test2 = 0;
            NodeNum = i;
            return
        end
        sizeO = size(Omarker);
        Q = [];
        for j = 1:sizeO(1)
            jishux = floor(Omarker(j,1) * 20) + 81;
            jishuy = floor(Omarker(j,2) * 20) + 81;
            jishuz = floor(Omarker(j,3) * 20) + 21;
            Q1 = jishuge(jishux,jishuy,jishuz);
            if Q1 <0.1
                Q1 = 0;
            end
            Q = [Q Q1];
        end
        sumQ = sum(Q);
        if sumQ == 0
            test2 = 0;
            NodeNum = i;
            return
        end
        OODirec = [0 0 0];
        for j = 1:sizeO(1)
            Odirection = Omarker(j,:) - Mnodes(i,1:3);
            Odirection = Odirection/norm(Odirection);
            Odirection = Odirection*Q(j)/sumQ;
            OODirec = OODirec + Odirection;
        end
         if level == 1  %主干角度变化规律不同，单独定义
                directionnow = Ddirection/norm(Ddirection) +  w1 * OODirec/norm(OODirec);
           
            directionnow = directionnow/norm(directionnow);
            position = Mnodes(i,1:3) + lengthi*directionnow;
            nodex  = position(1);
            nodey  = position(2);
            nodez  = position(3);
        else
            directionnow = Ddirection/norm(Ddirection) + w1* OODirec/norm(OODirec);
            
            zhongli = [0 0 -1] / (maxyear-year+1);
            directionnow = directionnow + w2 * zhongli;
            directionnow = directionnow/norm(directionnow);
            
            position = Mnodes(i,1:3) + lengthi*directionnow;
            nodex  = position(1);
            nodey  = position(2);
            nodez  = position(3);
           
        end
        
%         if level == 1  %主干角度变化规律不同，单独定义
%             theta = theta + rrr*CurveD/(maxL+3);
%             phy = phyt + rrr*CurveD/(maxL+3);
%             nodez = Mnodes(i,3) + cos(phy)*lengthi;
%             nodex = Mnodes(i,1) + sin(abs(phy))*lengthi*cos(theta);
%             nodey = Mnodes(i,2) + sin(abs(phy))*lengthi*sin(theta);
%         else
%             theta = theta+rrr*CurveD; %xy面角度
%             phy =phyt;
%             nodez = Mnodes(i,3) + cos(phy)*lengthi;
%             nodex = Mnodes(i,1) + sin(abs(phy))*lengthi*cos(theta);
%             nodey = Mnodes(i,2) + sin(abs(phy))*lengthi*sin(theta);
%             directionnow = [nodex nodey nodez] - Mnodes(i,1:3);
%             directionnow = directionnow/norm(directionnow);
%             zhongli = [0 0 -1] * radius* (NodeNum)/(level +3)* (NodeNum/2-i);
%             directionnow = directionnow + zhongli;
%             position = Mnodes(i,1:3) + lengthi*directionnow;
%             nodex  = position(1);
%             nodey  = position(2);
%             nodez  = position(3);
%         end
        