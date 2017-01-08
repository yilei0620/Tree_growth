function yy = Logisticjudge(t,a,b,c)

    
    if t >=5
  %      yy = a*b*c*t^(c-1)*exp(-b*t^c);
 %       yy = 3*a*b*exp(-b*t)*(1-exp(-b*t))^2; %Bertanfly
     yy = a*b*(a/c-1)*exp(-b*t)./(1+(a/c-1)*exp(-b*t)).^2; %Logistic
    else
        yy = 4;
    end