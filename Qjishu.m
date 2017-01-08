function [NodeNum jishuge test] = Qjishu(i,NodeNum,nodex,nodey,nodez,jishuge)
        jishux = floor(nodex * 20) + 81;
        jishuy = floor(nodey * 20) + 81;
        jishuz = floor(nodez * 20) + 21;
        if jishuge(jishux,jishuy,jishuz) <= 0.1 && jishuz < 6
            NodeNum = i;
            test = 0;
        else
            test = 1;
        end