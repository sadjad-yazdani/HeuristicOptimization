function Fun=TestFunction(X,FunNum)
[N,Dim]=size(X);
if (N>1)&&(all(FunNum~=[1,2,1000,24]))
    Fun=zeros(N,1);
    for i=1:N
        Fun(i,1)=TestFunction(X(i,:),FunNum);
    end
else

if FunNum==1
Fun=sum(X.^2,2);

elseif FunNum==2 
Fun=sum(abs(X),2)+prod(abs(X),2);


elseif FunNum==3
    Fun=0;
    for i=1:Dim
    Fun=Fun+sum(X(1:i))^2;
    end


elseif FunNum==4
    Fun=max(abs(X));


elseif FunNum==5
    Fun=sum(100*(X(2:Dim)-(X(1:Dim-1).^2)).^2+(X(1:Dim-1)-1).^2);


elseif FunNum==6
    Fun=sum(abs((X+.5)).^2);


elseif FunNum==7
    Fun=sum((1:Dim).*(X.^4))+rand;


elseif FunNum==8
    Fun=sum(-X.*sin(sqrt(abs(X))));


elseif FunNum==9
    Fun=sum(X.^2-10*cos(2*pi.*X))+10*Dim;


elseif FunNum==10
    Fun=-20*exp(-.2*sqrt(sum(X.^2)/Dim))-exp(sum(cos(2*pi.*X))/Dim)+20+exp(1);


elseif FunNum==11
    Fun=sum(X.^2)/4000-prod(cos(X./sqrt((1:Dim))))+1;


elseif FunNum==12
    Fun=(pi/Dim)*(10*((sin(pi*(1+(X(1)+1)/4)))^2)+sum((((X(1:Dim-1)+1)./4).^2).*...
        (1+10.*((sin(pi.*(1+(X(2:Dim)+1)./4)))).^2))+((X(Dim)+1)/4)^2)+sum(Ufun(X,10,100,4));

elseif FunNum==13
    Fun=.1*((sin(3*pi*X(1)))^2+sum((X(1,Dim-1)-1).^2.*(1+(sin(3.*pi.*X(2:Dim))).^2))+...
        ((X(Dim)-1)^2)*(1+(sin(2*pi*X(Dim)))^2))+sum(Ufun(X,5,100,4));


elseif FunNum==14
    aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;...
        -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
    %%%%%
    bS=zeros(1);
    for j=1:25
        bS(j)=sum((X'-aS(:,j)).^6);
    end
    Fun=(1/500+sum(1./((1:25)+bS))).^(-1);


elseif FunNum==15
    aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
    bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
    Fun=sum((aK-((X(1).*(bK.^2+X(2).*bK))./(bK.^2+X(3).*bK+X(4)))).^2);


elseif FunNum==16
    Fun=4*(X(1)^2)-2.1*(X(1)^4)+(X(1)^6)/3+X(1)*X(2)-4*(X(2)^2)+4*(X(2)^4);


elseif FunNum==17
    Fun=(X(2)-(X(1)^2)*5.1/(4*(pi^2))+5/pi*X(1)-6)^2+10*(1-1/(8*pi))*cos(X(1))+10;


elseif FunNum==18
    Fun=(1+(X(1)+X(2)+1)^2*(19-14*X(1)+3*(X(1)^2)-14*X(2)+6*X(1)*X(2)+3*X(2)^2))*...
        (30+(2*X(1)-3*X(2))^2*(18-32*X(1)+12*(X(1)^2)+48*X(2)-36*X(1)*X(2)+27*(X(2)^2)));


elseif FunNum==19
    aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
    pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
    Fun=0;
    for i=1:4
    Fun=Fun-cH(i)*exp(-(sum(aH(i,:).*((X-pH(i,:)).^2))));
    end


elseif FunNum==20
    aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
    Fun=0;
    for i=1:4
    Fun=Fun-cH(i)*exp(-(sum(aH(i,:).*((X-pH(i,:)).^2))));
    end

elseif FunNum==21
    aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
    cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
    Fun=0;
      for i=1:5
        Fun=Fun-((X-aSH(i,:))*(X-aSH(i,:))'+cSH(i))^(-1);
      end


elseif FunNum==22
    aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
    cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
    Fun=0;
      for i=1:7
        Fun=Fun-((X-aSH(i,:))*(X-aSH(i,:))'+cSH(i))^(-1);
      end


elseif FunNum==23
    aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
    cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
    Fun=0;
      for i=1:10
        Fun=Fun-((X-aSH(i,:))*(X-aSH(i,:))'+cSH(i))^(-1);
      end
elseif FunNum==24
    Fun=mean(cos(X).*exp(-X/10),2)+exp(-pi/10);
elseif FunNum==100
    global StartTime %#ok<TLEV>
    if isempty(StartTime)
        StartTime=cputime;
    end
    t=cputime-StartTime;
    Fun=X(1).^2+sin(t+X(2)).^2;
elseif FunNum==1000
    RealVal=[0.59,0.4,4,4.8e-3,10,30e-3,1.2,1.35,1];
    Fun=mean(abs(X-repmat(RealVal,N,1)),2)+0.01*rand(N,1);
else
    error('the function number is unavaibel')
end
end

function y=Ufun(x,a,k,m)
y=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
return
