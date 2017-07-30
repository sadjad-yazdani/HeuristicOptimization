function [Low,High]=LowHighTestFunction(FunNum,N,Dim)
if nargin<2
    N=1;
    Dim=DimentionFunction(FunNum);
end

if FunNum==1
    down=-100;up=100;
elseif FunNum==2
    down=-10;up=10;
elseif FunNum==3
    down=-100;up=100;
elseif FunNum==4
    down=-100;up=100;
elseif FunNum==5
    down=-30;up=30;
elseif FunNum==6
    down=-100;up=100;
elseif FunNum==7
    down=-1.28;up=1.28;
elseif FunNum==8
    down=-500;up=500;
elseif FunNum==9
    down=-5.12;up=5.12;
elseif FunNum==10
    down=-32;up=32;
elseif FunNum==11
    down=-600;up=600;
elseif FunNum==12
    down=-50;up=50;
elseif FunNum==13
    down=-50;up=50;
elseif FunNum==14
    down=-65.536;up=65.536;
elseif FunNum==15
    down=-5;up=5;
elseif FunNum==16
    down=-5;up=5;
elseif FunNum==17
    down=[-5,0];up=[10,15];
elseif FunNum==18
    down=-2;up=2;
elseif FunNum==19
    down=0;up=1;
elseif FunNum==20
    down=0;up=1;
elseif FunNum==21
    down=0;up=10;
elseif FunNum==22
    down=0;up=10;
elseif FunNum==23
    down=0;up=10;
elseif FunNum==24
    down=0;up=4*pi;
elseif FunNum==1000
    RealVal=[0.59,0.4,4,4.8e-3,10,30e-3,1.2,1.35,1];
    down=0.9*RealVal;
    up=1.1*RealVal;
 else
    error('the function number is unavaibel')
end
if any(FunNum==[17 1000])
    Low=repmat(down,N,1);  %low boundry
    High=repmat(up,N,1);      %high boundry
else
    Low=down*ones(N,Dim);  %low boundry
    High=up*ones(N,Dim);      %high boundry
end