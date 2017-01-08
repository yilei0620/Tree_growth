function jishuge  = Qjishu2(nodex,nodey,nodez,jishuge,year,NNN)
        a = 1;
if NNN == 1;
        if year <= 14
            b = 1.85;
        else
            b = 1.85 + (year-14) *(2.2-1.85)/6;
        end
elseif NNN == 2
     if year <= 10
            b = 1.87;
     else
            b = 1.87 + (year-10) *(2.2-1.87)/10;
     end

end
%         b = 1.85 + (year) *(2.2-1.85)/20;
        N = 20 ;
        jishux = floor((nodex+0.0001) * 20) + 81;
        jishuy = floor((nodey+0.0001) * 20) + 81;
        jishuz = floor((nodez+0.0001) * 20) + 21;
        if jishuz - N <=0
            N = jishuz-5;
        end
        % 上半部分的金字塔形遮挡
        for q = 0 : 1: N
                jishuge(jishux-q:jishux+q,jishuy-q:jishuy+q,jishuz-q) = jishuge(jishux-q:jishux+q,jishuy-q:jishuy+q,jishuz-q)-a*b^(-q);
        end
        % 下半部分的长方体形遮挡
        for q = N +1 :jishuz-20
            jishuge(jishux-N:jishux+N,jishuy-N:jishuy+N,jishuz-q) = jishuge(jishux-N:jishux+N,jishuy-N:jishuy+N,jishuz-q)-a*b^(-q);
        end
        