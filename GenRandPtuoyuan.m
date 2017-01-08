function dianyun = GenRandPtuoyuan(a,b,c,suijidiangeshu)
% t1 = rand(1,suijidiangeshu)*2*pi;
% t2 = rand(1,suijidiangeshu)*pi;
% a = rand(1,suijidiangeshu)*a;
% b = rand(1,suijidiangeshu)*b;
% c = rand(1,suijidiangeshu)*c;
%   x = a .* sin(t2).* cos(t1);
%   y = b .* sin(t2).* sin(t1);
%   z = c .* cos(t2);
% A = [x' y' z'];


buchang1 = 2*a / suijidiangeshu;
dianyun = [];
for aa = -a :buchang1:a
    buchang2 = 2*b / suijidiangeshu;
    for bb = -b :buchang2:b
        buchang3 = 2*c / suijidiangeshu/(c/a);
        for cc = -c : buchang3 :c
            if aa^2/a^2 + bb^2/b^2 + cc^2/c^2 <= 1
                dianyun = [dianyun;aa bb cc];
            end
        end
    end
end
