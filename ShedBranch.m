function [treedata, I]= ShedBranch(treedata,ratio,I,jishuge)

sizet = size(treedata);
treedata = [treedata(:,1:7) zeros(sizet(1),2) ones(sizet(1),1) zeros(sizet(1),3) treedata(:,8)];
sizei= size(I);
for i = 1:2:sizei(2)
    for j = I(i):I(i+1)
        jishux = floor(treedata(j,1) * 20) + 81;
        jishuy = floor(treedata(j,2) * 20) + 81;
        jishuz = floor(treedata(j,3) * 20) + 21;
        Q = jishuge(jishux,jishuy,jishuz)+1;
        if Q >= 0
            treedata(j,8) = Q;
        else
            treedata(j,8) = 0.0001;
        end
    end
end

for m = sizei(2): -2 : 2
    for i = I(m):-1:I(m-1)
        num = treedata(i,7);
        r = [];
        for j = m+1:2:sizei(2)
            if treedata(I(j),7) == num
                r = [r treedata(I(j),9)-treedata(I(j),8)];
            end
        end
        if isempty(r)
            treedata(i,9) = treedata(i+1,9)+treedata(i,8);
        else
            sizerr = size(r);
            treedata(i,9) = sum(r) + treedata(i+1,9);
            treedata(i,10) = sizerr(2)+treedata(i,10);
            treedata(i,8) = sum(r);
        end
    end
end
shedb = [];
for m = 1:2:sizei(2)-1
    biaozhi = 0;
    treedata(I(m),11) =  (treedata(I(m),9) - treedata(I(m),8))/(I(m+1) - I(m));
    if treedata(I(m),11) < ratio
         for mm = I(m) + 1 : I(m+1)
             if treedata(mm,10) > 1
                 biaozhi = 1;
                 break
             end
         end
         if biaozhi ==0
            shedb = [shedb [I(m) I(m+1);m m+1]];
         end
    end
end
sizesd =size(shedb);
for i = sizesd(2) -1 : -2 : 1
        N = shedb(1,i+1) -shedb(1,i);
        treedata(shedb(1,i):shedb(1,i+1)+1,:) = [];
        I(1,shedb(2,i)+2:sizei(2)) = I(1,shedb(2,i)+2:sizei(2)) - (N+2);
        I(:,shedb(2,i):shedb(2,i)+1) = [];
        sizei = size(I);
end

treedata = treedata(:,1:8);
