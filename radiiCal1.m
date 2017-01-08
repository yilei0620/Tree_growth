function treedata = radiiCal1(treedata,I,radii,nn)
sizei= size(I);
for m = sizei(2): -2 : 2
    for i = I(m):-1:I(m-1)
        num = treedata(i,7);
        r = [];
        for j = m+1:2:sizei(2)
            if treedata(I(j),7) == num
                r = [r treedata(I(j),4)];
            end
        end
        if isempty(r) && i ~= I(m)
            temp = treedata(i+1,4);
             if treedata(i,4) <= temp
                treedata(i,4) = temp;
             end
        elseif  isempty(r) && i ==I(m)
            treedata(i,4) = radii;
        else
            temp = (sum(r.^nn)+treedata(i+1,4)^nn)^(1/nn);
            if treedata(i,4)< temp
              treedata(i,4) = temp;
            end
        end
    end
end
