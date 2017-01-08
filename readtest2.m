

filename = 'Treedata1.obj';
fid = fopen(filename,'r');
n = 1;
feivN = [];
treedata = [];
r = 0.006;
% treedata2 = [];
% treedata3 = [];
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
                treedata = [treedata;t1 t2 t3 t4 t5 t6 t7 n];
%                 treedata2 = [treedata2;t1 t2+2 t3 t4 n];
%                 treedata3 = [treedata3;t2 t1+4 t3 t4 n];
            else
                feivN = [feivN n];
                treedata = [treedata;0 0 0 0 0 0 0 0];
%                 treedata2 = [treedata2;0 0 0 0 0];
%                 treedata3 = [treedata3;0 0 0 0 0];
            end
            n=n+1;
end
fclose(fid);
treedata = [treedata;0 0 0 0 0 0 0 0];
feivN = [feivN n];
sizen = size(feivN);
I = [];
for i =1: sizen(2)-1
    if feivN(i+1) - feivN(i) >1
        I = [I feivN(i)+1 feivN(i+1)-1];
    end
end
sizei= size(I);

% fp = fopen(filename,'w');
%     sizei = size(I);
%     for m = 1:2:sizei(2)-1
%         fprintf(fp,'%s','g Branch ');
%         fprintf(fp,'\r\n');
%         for i = I(m):I(m+1)
%                if treedata(i+1,6) <=year
%                    fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata(i,1),treedata(i,2),treedata(i,3),treedata(i,4),treedata(i,5),treedata(i,6),treedata(i,7));
%                    fprintf(fp,'\r\n'); 
%                end
%         end
%     end
%  fclose(fp);


fp = fopen(filename,'w');
for m = 1:2:sizei(2)-1
%     for i = I(m):I(m+1)-1
%             w = treedata(i,4)*60;
%             if treedata(i+1,6) <=year
%                 fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata(i,1),treedata(i,2),treedata(i,3),treedata(i,4),treedata(i,5),treedata(i,6),treedata(i,7));
%                        fprintf(fp,'\r\n'); 
% %                 plot3(treedata(i:i+1,1),treedata(i:i+1,2),treedata(i:i+1,3),'-','Color',[[0.1 0.5 0.1]])
%     %             plot3(treedata2(i:i+1,1),treedata2(i:i+1,2),treedata2(i:i+1,3),'b-','LineWidth',w)
%     %             plot3(treedata3(i:i+1,1),treedata3(i:i+1,2),treedata3(i:i+1,3),'m-','LineWidth',w)
% %                 hold on
%             end
%           
        if treedata(I(m),4) <=r
                continue
        end
            fprintf(fp,'%s','g Branch ');
            fprintf(fp,'\r\n');
            for i = I(m):I(m+1)
                   if treedata(i,4) > r 
                       fprintf(fp,'%s %d %d %d %d %d %d %d','v',treedata(i,1),treedata(i,2),treedata(i,3),treedata(i,4),treedata(i,5),treedata(i,6),treedata(i,7));
                       fprintf(fp,'\r\n'); 
                   end
            end
%     end
end
fclose(fp);
%   axis equal
  
%   
% filename = 'Treedata.txt';
% fid = fopen(filename,'r');
% n = 1;
% feivN = [];
% treedata = [];
% % treedata2 = [];
% % treedata3 = [];
% while ~strcmpi(tline,'GrowthLoopEnd')
%     
%         
%             tline = fgetl(fid);
%             if ~ischar(tline), break, end
%             if strncmp(tline,'v',1)
%                 [temp1 temp2]= strtok(tline,' '); %temp1 = v
%                 [temp1 temp2]= strtok(temp2,' '); %t1 = x
%                 t1 = str2num(temp1);
%                 [temp1 temp2]= strtok(temp2,' '); %t2 = y
%                 t2 = str2num(temp1);
%                 [temp1 temp2]= strtok(temp2,' '); %t3 = z
%                 t3 = str2num(temp1);
%                 [temp1 temp2]= strtok(temp2,' '); %t4 = r
%                 t4 = str2num(temp1);
%                 [temp1 temp2]= strtok(temp2,' '); %t5 = l
%                 t5 = str2num(temp1); 
%                 t6 = str2num(temp2); %t6 = year
%                 treedata = [treedata;t1 t2 t3 t4 t5 t6 n];
% %                 treedata2 = [treedata2;t1 t2+2 t3 t4 n];
% %                 treedata3 = [treedata3;t2 t1+4 t3 t4 n];
%             else
%                 feivN = [feivN n];
%                 treedata = [treedata;0 0 0 0 0 0 0];
% %                 treedata2 = [treedata2;0 0 0 0 0];
% %                 treedata3 = [treedata3;0 0 0 0 0];
%             end
%             n=n+1;
% end
% fclose(fid);
% sizen = size(feivN);
% I = [];
% for i =1: sizen(2)-1
%     if feivN(i+1) - feivN(i) ~=1
%         I = [I feivN(i)+1 feivN(i+1)-1];
%     end
% end
% sizei= size(I);
% 
 for m = 1:2:sizei(2)-1
     for i = I(m):I(m+1)-1
             w = treedata(i,4)*30;
             plot3(treedata(i:i+1,1),treedata(i:i+1,2),treedata(i:i+1,3),'b-','LineWidth',w)
%             plot3(treedata2(i:i+1,1),treedata2(i:i+1,2),treedata2(i:i+1,3),'b-','LineWidth',w)
% %             plot3(treedata3(i:i+1,1),treedata3(i:i+1,2),treedata3(i:i+1,3),'m-','LineWidth',w)
             hold on
%         
     end
 end
 axis equal