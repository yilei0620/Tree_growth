function [year, NodeNo, jishuge]= TreeGrow2(Mlevels,...
    BmaxAngle,year,Maxyear,filename1,NodeNo,jishuge,Ltheta,lamuda,aaa)
year = year + 1;
NN = size(NodeNo);
NN = NN(1);

if year <= Maxyear  %????????
    %% ????????????
    for i = 1:NN
        fid = fopen(filename1{i},'r');
        n = 1;
        feivN = [];
        eval(['treedata',num2str(i),'= [];']) ;
        while 1
                    tline = fgetl(fid);
                    if ~ischar(tline), break, end
                    if strncmp(tline,'v',1)
                        [temp1 temp2]= strtok(tline,' '); %temp1 = v
                        [temp1 temp2]= strtok(temp2,' '); %t1 = x
                        t1 = str2num(temp1);
                        [temp1 temp2]= strtok(temp2,' '); %t2 = y
                        t2 = str2num(temp1);
                        [temp1 temp2]= strtok(temp2,' '); %t3 = z
                        t3 = str2num(temp1);
                        [temp1 temp2]= strtok(temp2,' '); %t4 = r
                        t4 = str2num(temp1);
                        [temp1 temp2]= strtok(temp2,' '); %t5 = l
                        t5 = str2num(temp1); 
                        [temp1 temp2]= strtok(temp2,' '); 
                        t6 = str2num(temp1); %t6 = year
                        t7 = str2num(temp2);
                        eval(['treedata',num2str(i),' = [treedata',num2str(i),';t1 t2 t3 t4 t5 t6 t7 n];']) ;
                    else
                        feivN = [feivN n];
                        eval(['treedata',num2str(i),' = [treedata',num2str(i),';0 0 0 0 0 0 0 0];']) ;
                    end
                    n=n+1;
        end
        fclose(fid);
        eval(['treedata',num2str(i),' = [treedata',num2str(i),';0 0 0 0 0 0 0 0];']) ;
        feivN = [feivN n];
        sizen = size(feivN);
        eval(['I',num2str(i),' = [];']);
        for ii =1: sizen(2)-1
            if feivN(ii+1) - feivN(ii) >1
                eval(['I',num2str(i),'= [I',num2str(i),' feivN(ii)+1 feivN(ii+1)-1];']);
            end
        end
    end
    %%  ??????????????
    BranchNo = 1;
    yearloop = year ;
    Nyear = year - 1;
    for i = 1 :NN
        eval(['BnodeI',num2str(i),'= budfate3(lamuda(i),aaa(i),jishuge,treedata',num2str(i),',I',num2str(i),',Nyear,Mlevels,i);']);
    end
    if isempty(BnodeI1) 
%         && isempty(BnodeI2) && isempty(BnodeI3) && isempty(BnodeI4) && isempty(BnodeI5)
        return
    end
    %% ????????????????
    a = [100 70];
    b = 0.34;
    c = 3;
    n = [0 0];
    for j = 1:NN
        n(j) = Logisticjudge(year,a(j),b,c);
    end
    %% ??????????????????????????????
            n = n + 4;
            for i = 1 :NN
                 eval(['randP',num2str(i),'= GenRandPtuoyuan3(BnodeI',num2str(i),',n(i),150,treedata',num2str(i),',year + 1);']); % ????????????????????
            end
            if ~mod(year,2)
                for i = NN:-1:1
                    eval(['BnodeI =BnodeI',num2str(i),';']);
                    if isempty(BnodeI)
                        continue
                    end
                    eval(['[level, year, BranchNo, NodeNo1, jishuge, Ltheta1, treedata',num2str(i),', I',num2str(i),...
                        ' ] = GenTree7(BmaxAngle,year,BranchNo,NodeNo(' ,num2str(i),',1),jishuge,Ltheta(',num2str(i),',1),treedata',...
                        num2str(i),',BnodeI',num2str(i),',I',num2str(i),',randP',num2str(i),',i);'])
                     NodeNo(i) = NodeNo1;
                     Ltheta(i) = Ltheta1;
                end
            else
                for i = 1 : NN
                    eval(['BnodeI =BnodeI',num2str(i),';']);
                    if isempty(BnodeI)
                        continue
                    end
                    eval(['[level, year, BranchNo, NodeNo1, jishuge, Ltheta1, treedata',num2str(i),', I',num2str(i),...
                        ' ] = GenTree7(BmaxAngle,year,BranchNo,NodeNo(' ,num2str(i),',1),jishuge,Ltheta(',num2str(i),',1),treedata',...
                        num2str(i),',BnodeI',num2str(i),',I',num2str(i),',randP',num2str(i),',i);'])
                     NodeNo(i) = NodeNo1;
                     Ltheta(i) = Ltheta1;
                end
            end
            for i = 1 :NN
                 eval(['treedata',num2str(i),' = radiiCal1(treedata',num2str(i),',I',num2str(i),',0.003,2.6);']); % ??????
            end
        %% ????????????????????????????????????
    
    if year >= 4
        for i = 1 :NN
			for j = 1 : 5
                if i == 1
                    eval(['[treedata',num2str(i),', I',num2str(i),']= ShedBranch(treedata',num2str(i),',0.35,I',num2str(i),',jishuge);']);
                elseif i == 2
                    eval(['[treedata',num2str(i),', I',num2str(i),']= ShedBranch(treedata',num2str(i),',0.25,I',num2str(i),',jishuge);']);
                end
			end
        end
    end
    
    if year == Maxyear
		for i =1 :NN
			for j = 1 :10
                if i==1
                    eval(['[treedata',num2str(i),', I',num2str(i),']= ShedBranch(treedata',num2str(i),',0.45,I',num2str(i),',jishuge);']);
                elseif i ==2
                    eval(['[treedata',num2str(i),', I',num2str(i),']= ShedBranch(treedata',num2str(i),',0.25,I',num2str(i),',jishuge);']);
                end
			end
		end
    end
    
    %% ????????????
    for ii = 1:NN
        fp = fopen(filename1{ii},'w');
        eval(['II = I',num2str(ii),';']);
        eval(['treedata = treedata',num2str(ii),';']);
        sizei = size(II);
        for m = 1:2:sizei(2)-1
            fprintf(fp,'%s','g Branch ');
            fprintf(fp,'\r\n');
            for i = II(m):II(m+1)
                   fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata(i,1),treedata(i,2),treedata(i,3),treedata(i,4),treedata(i,5),treedata(i,6),treedata(i,7));
                   fprintf(fp,'\r\n'); 
            end
        end
        fclose(fp);
    end
    
   if ~mod(year,2)
        name = strcat('loop',num2str(year));
        name = strcat(name,'.obj');
        fp = fopen(name,'w');
        sizei = size(I1);
        for m = 1:2:sizei(2)-1
            fprintf(fp,'%s','g Branch ');
            fprintf(fp,'\r\n');
            for i = I1(m):I1(m+1)
                   fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata1(i,1),treedata1(i,2),treedata1(i,3),treedata1(i,4),treedata1(i,5),treedata1(i,6),treedata1(i,7));
                   fprintf(fp,'\r\n'); 
            end
        end
        fprintf(fp,'\r\n'); 
        fprintf(fp,'\r\n'); 
%        sizei = size(I2);
 %       for m = 1:2:sizei(2)-1
  %          fprintf(fp,'%s','g Branch ');
 %           fprintf(fp,'\r\n');
 %           for i = I2(m):I2(m+1)
  %                 fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata2(i,1),treedata2(i,2),treedata2(i,3),treedata2(i,4),treedata2(i,5),treedata2(i,6),treedata2(i,7));
 %                  fprintf(fp,'\r\n'); 
  %          end
  %      end
  %      fclose(fp);
    end
    
    year = yearloop;
    [year, NodeNo, jishuge]= TreeGrow2(Mlevels,...
    BmaxAngle,year,Maxyear,filename1,NodeNo,jishuge,Ltheta,lamuda,aaa);
end
