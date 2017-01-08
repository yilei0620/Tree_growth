function randP2 = ChooserandP(Broot,xianzhi,Blength,randP,Brootpri)
xianzhi = xianzhi  + 2;
Broot = Broot(1:3);
direction = Broot - Brootpri;
% sizer = size(randP);
% i = 1;

randP2 = rangesearch(randP,Broot,xianzhi*Blength);
rand_ind = randP2{1};
randP2 = randP.X(rand_ind,:);
direction2 = bsxfun(@minus, randP2 , Broot);
temp1 = bsxfun(@times,direction2, direction);
temp1 = sum(temp1,2);
temp2 = sqrt(sum(direction2.^2,2));
jiaodu = temp1./(temp2.*norm(direction));
jiaodu = acos(jiaodu)*180/pi;
ang_temp = jiaodu <= 90;
randP2 = randP2(ang_temp,:);
rand_ind = rand_ind(ang_temp);
randP2 = [randP2 rand_ind'];
randP2 = sort(randP2,4);
% while 1
%     if i > sizer(1)
%         break
%     end
%     direction2 = randP(i,:) - Broot;
%     jiaodu = sum(direction2 .* direction)/(norm(direction2)*norm(direction));
%     jiaodu = acos(jiaodu)*180/pi;
%     if jiaodu <= 90 && norm(randP(i,:)-Broot) <= xianzhi*Blength
%         randP2 = [randP2;randP(i,:) i];
%      end
%     i = i+1;
% end


