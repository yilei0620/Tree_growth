function BnodeI = budfate3(lamuda,aaa,jishuge,treedata,I,year,Mlevels,NNNN)


K = 0.5; %重要参数
sizet = size(treedata);
treedata = [treedata(:,1:7) zeros(sizet(1),2) ones(sizet(1),1) zeros(sizet(1),3) treedata(:,8) ones(sizet(1),3)];
sizei= size(I);
for i = 1:2:sizei(2)
    for j = I(i):I(i+1)
        jishux = floor(treedata(j,1) * 20) + 81;
        jishuy = floor(treedata(j,2) * 20) + 81;
        jishuz = floor(treedata(j,3) * 20) + 21;
        Q = jishuge(jishux,jishuy,jishuz)+1;
        if Q > 0 
            treedata(j,8) = Q.^((year - treedata(j,6)+1)^(1/2));
        else
            treedata(j,8) = 0.0001;
        end
       
    end
end
for m = sizei(2): -2 : 2
    for i = I(m):-1:I(m-1)
        num = treedata(i,7);
        r = [];
        nnn = 0;
%         nnn2 = 0;
        for j = m+1:2:sizei(2)
            if treedata(I(j),7) == num
                r = [r treedata(I(j),9)-treedata(I(j),8)];
                if i~=I(m-1)
                     nnn = nnn + sum(treedata(I(j)+1:I(j+1),16));
%                      nnn2 = nnn2 + I(j+1) - I(j);
                end
            end
        end
        if nnn ==0
            treedata(i,9) = treedata(i+1,9)+treedata(i,8);
        else
            sizerr = size(r);
            treedata(i,9) = sum(r) + treedata(i+1,9);
            treedata(i,10) = sizerr(2)+treedata(i,10);
            treedata(i,8) = sum(r);
            treedata(i,16) = nnn;
%             treedata(i,17) = nnn2;
        end
    end
end
treedata(I(1),11) = aaa * (treedata(I(1),9) -  treedata(I(1),8));

for m = 1 :2: sizei(2) - 1
    N = I(m+1) - I(m);
    treedata(I(m),12) =( treedata(I(m),9) - treedata(I(m),8) )/ N;
    Vcizhi = treedata(I(m),11);
    for hang = I(m)+1 : I(m+1)
        if treedata(hang,10) > 1
               Qm = treedata(hang,9)-treedata(hang,8);
               Ql = treedata(hang,8);
               Vlcizhi = Vcizhi *((1-lamuda)*Ql/(lamuda*Qm+(1-lamuda)*Ql));
               treedata(hang,11) = Vlcizhi / (treedata(hang,16));
               Vcizhi = Vcizhi - Vlcizhi;
               treedata(hang,15) = Vlcizhi / (treedata(hang,10)-1);
        else
            
               Vlcizhi = Vcizhi * treedata(hang,8) / treedata(hang,9);
               treedata(hang,11) = Vlcizhi;
                treedata(hang,15) = Vlcizhi;
               Vcizhi = Vcizhi - Vlcizhi ;
               if treedata(hang,9) ==0
                   treedata(hang,11) = 0;
               end
        end
    end
    
    level = treedata(I(m),5);
    if NNNN == 1
    
        if ( level == 1 && year <= 5 ) || (level == 1 && year <= 5)  %顶端控制
               geshu = 1;
               if N > 2
                    kk = (0.006-1)/(K*N-1);
               else
                   kk = 0;
               end
               for mm = I(m)+1 : I(m+1)
                   if geshu <= K*N
                       Wi = 1 + kk*(geshu-1);
                   else
                       Wi = 0.006;
                   end
                   geshu = geshu + 1;
                   if mm == I(m)+1
                       treedata(I(m+1),12) = Wi;
                       continue
                   end
                   jiluV = 0;
                   for mmm = I(m)+1 : I(m+1)-1
                       if treedata(mmm,11) >= jiluV && treedata(mmm,12) == 0;
                           jiluV = treedata(mmm,11);
                           temp = mmm;
                       end
                   end
                   treedata(temp,12) = Wi;
               end

        else
           geshu = 1;
           if N > 2
                    kk = (0.006-1)/(K*N-1);
           else
                   kk = 0;
           end
           for mm = I(m)+1 : I(m+1)
               if geshu <= K*N
                   Wi = 1 + kk*(geshu-1);
               else
                   Wi = 0.006;
               end
               geshu = geshu + 1;
               jiluV = 0;
               for mmm =I(m)+1 : I(m+1)
                   if treedata(mmm,11) >= jiluV && treedata(mmm,12) == 0;
                       jiluV = treedata(mmm,11);
                       temp = mmm;
                   end
               end
               treedata(temp,12) = Wi;
           end
        end
    elseif NNNN ==2
         if ( level == 1 && year <= 2 ) || (level == 1 && year <= 2)  %顶端控制
           geshu = 1;
           if N > 2
                kk = (0.006-1)/(K*N-1);
           else
               kk = 0;
           end
           for mm = I(m)+1 : I(m+1)
               if geshu <= K*N
                   Wi = 1 + kk*(geshu-1);
               else
                   Wi = 0.006;
               end
               geshu = geshu + 1;
               if mm == I(m)+1
                   treedata(I(m+1),12) = Wi;
                   continue
               end
               jiluV = 0;
               for mmm = I(m)+1 : I(m+1)-1
                   if treedata(mmm,11) >= jiluV && treedata(mmm,12) == 0;
                       jiluV = treedata(mmm,11);
                       temp = mmm;
                   end
               end
               treedata(temp,12) = Wi;
           end
           
         else
       geshu = 1;
       if N > 2
                kk = (0.006-1)/(K*N-1);
       else
               kk = 0;
       end
       for mm = I(m)+1 : I(m+1)
           if geshu <= K*N
               Wi = 1 + kk*(geshu-1);
           else
               Wi = 0.006;
           end
           geshu = geshu + 1;
           jiluV = 0;
           for mmm =I(m)+1 : I(m+1)
               if treedata(mmm,11) >= jiluV && treedata(mmm,12) == 0;
                   jiluV = treedata(mmm,11);
                   temp = mmm;
               end
           end
           treedata(temp,12) = Wi;
       end
        end
    end
    Vcizhi = treedata(I(m),11);
    sumQW = 0;
    for iii = I(m)+1:I(m+1)
        if treedata(iii,10) == 1
            sumQW = sumQW + treedata(iii,15)*treedata(iii,12);
        else
            sumQW = sumQW + treedata(iii,15)*treedata(iii,12)*(treedata(iii,10)-1);
        end
    end
%     sumQW = sum(treedata(I(m)+1:I(m+1),15).*treedata(I(m)+1:I(m+1),12).*treedata(I(m)+1:I(m+1),10));
%     .*treedata(I(m)+1:I(m+1),15)./treedata(I(m)+1:I(m+1),10));
    for iii = I(m)+1:I(m+1)
        if treedata(iii,10) == 1
            treedata(iii,13) = Vcizhi * (treedata(iii,15).*treedata(iii,12))/sumQW;
        else
            treedata(iii,13) = Vcizhi * (treedata(iii,15).*treedata(iii,12)*(treedata(iii,10)-1))/sumQW;
        end
    end
%     treedata(I(m)+1:I(m+1),13) = Vcizhi * (treedata(I(m)+1:I(m+1),15).*treedata(I(m)+1:I(m+1),12).*treedata(I(m)+1:I(m+1),10))/sumQW;
    for mm = I(m)+1:I(m+1)
        if treedata(mm,10) > 1 
            for mmm = m+2 : 2 : sizei(2) - 1
                if treedata(I(mmm),7) == treedata(mm,7)
%                     NNN = I(mmm+1) - I(mmm);
%                     treedata(I(mmm),11) = treedata(mm,13) * NNN / treedata(mm,17);
%                     treedata(I(mmm),11) = treedata(mm,13)*((treedata(I(mmm),9)-treedata(I(mmm),8))/treedata(mm,8));
                    NNN = sum(treedata(I(mmm)+1:I(mmm+1),16));
                    treedata(I(mmm),11) = treedata(mm,13) * NNN / treedata(mm,16);
%                     (treedata(mm,10)) * ((treedata(I(mmm),9)-treedata(I(mmm),8))/treedata(mm,8));
                end
            end
        end
    end
end
BnodeI = [];
shuzhi1 = 0;
shuzhi2 = 1;
for i = 1 : sizet(1)
    if shuzhi2 <= sizei(2)    
        if i == I(shuzhi2)
            shuzhi2 = shuzhi2 + 2;
            shuzhi1 = shuzhi1 + 1;
            continue
        end
    end
%     if treedata(I(m),12) < 0.005
%         treedata(I(m):I(m+1)+1,:) = [];
%         I(1,m+2:sizei(2)) = I(1,m+2:sizei(2)) - (N+2);
%         I(:,m:m+1) = [];
%         sizei = size(I);
%         m = m -2;
%         continue
%     end
    if treedata(i,7) ~=0 && treedata(i,10) <2 && treedata(i,13) >= 1   && treedata(i,5)<Mlevels 
        BnodeI = [BnodeI [i;treedata(i,13);shuzhi1]];
    end
    
end
year
