 clc
clear 
%riaziat va karbordha
%har do ma be tore kamel dar har marhale hamzaman dar neveshtan code
%hamkari dashtim(ba narm afzare anydesk)
%hd=hade astane
[num , str,row]=xlsread('injury2.xlsx');
%o1=vizhegi numeric o2=vizhegi nominal
esm=row(1,:);
row(1,:)=[];
str(1,:)=[];
label=row(:,end);
[m,n]=size(row);
for q1=1:m
    s=str{q1,10};
    w=strfind(s,'.');
    if(~isempty(w))
    num(q1,10)=str2num(s);
    row{q1,10}=str2num(s);
    end
end
str(:,10)=[];
str(:,end)=[];
p1=1;
p2=1;
for i0=1:n-1
    l1=row{1,i0};
    asci=double(l1);
    if(length(asci)>1)
        o2(p2)=i0;
        p2=p2+1;
    elseif(length(asci)==1)
                Q=num2str(l1);
        if(Q==l1)
             o2(p2)=i0;
              p2=p2+1;
        else
            o1(p1)=i0;
            p1=p1+1;
    
        end
    end
end
p1=p1-1;
p2=p2-1;
x=ceil(0.2*m);
train=cell(m-x,n);
test=cell(x,n);
g=0;
l=1;
ki=1;
Tt=cell(2,5);
s1=zeros(1,x);
%dar edame dade train va teste har marhale ra moshakhas mikonim.
while(l<=5)
    while(ki<=x)
ran=randi([1 m],1,1);  
    if(g==ran && g==m)
        ran=ran-1;
    elseif(g==ran && g<m)
        ran=ran+1;
    end
    s1(ki)=ran;
    ki=ki+1;
    g=ran;
    end
    ki=1;
    s1=sort(s1);
    s2=1:m;
    s2(s1)=[];
    for i7=1:x
        for ip=1:n
            test{i7,ip}=row{s1(i7),ip};
        end
    end
    for ip2=1:m-x
        for ip1=1:n
            train{ip2,ip1}=row{s2(ip2),ip1};
        end
    end
    Tt{1,l}=train;
    Tt{2,l}=test;
    l=l+1;
end
%halghe zir tedade halat haye yek vizhegie nominal ra moshakhas mikonad.
r=1;
ls=1;
halat=zeros(1,p2);
for ij1=o2
    h1=str{1,ij1};
    for ij3=2:m
        h2=str{ij3,ij1};
        if(~strcmp(h1,h2))
            r=r+1;
            for ij4=ij3:m
                s1=str{ij4,ij1};
                if(strcmp(s1,h2))
                    str{ij4,ij1}=h1;
                end
            end
        end
    end
    halat(1,ls)=r;
    r=1;
    ls=ls+1;
end
%halghe zir  labele haye mara estekhraj mikonad.
PR1=label{1,1};
R1=0;
PR2=label{2,1};
R2=0;
for v=3:m
    if(strcmp(PR1,PR2))
        PR2=label{v,1};
    else
        break;
    end
end
Ttx=cell(2,5);
train1x=cell(1,n);
train2x=cell(1,n);
c1=1;
c2=1;
mk=m-x;
%dar edame por kardan jadval ehtemalati

for iz1=1:5
    A=Tt{1,iz1};
    for iz3=1:mk
        a1=A{iz3,end};
        if(strcmp(a1,PR1))
            train1x(c1,:)=A(iz3,:);
            c1=c1+1;
        else
            train2x(c2,:)=A(iz3,:);
            c2=c2+1;
        end
    end
    Ttx{1,iz1}=train1x;
    Ttx{2,iz1}=train2x;
    c1=1;
    c2=1;
    train1x=cell(1,n);
    train2x=cell(1,n);
end
jadval=cell(2,5);
jadval1=cell(1,p2);

%halghe iz0 baraye har marhalast
for iz0=1:5
    row1=cell(1,1);
    row1=Ttx(1,iz0);
    M=row1{1,1};
    [OP,~]=size(M);
    %halghe iz1 baraye por kardane sutun haye jadval dar har
    %marhalast
    for iz1=1:p2
        hx=halat(iz1);
        hl=cell(hx,1);
        H=cell(1,1);
        H=M(:,o2(iz1));
        %halghe zir baraye har halate har vizhegi ast
        for iz2=1:hx
              [w1,w2]=size(H);
          hm=cell(1,2);
         if(w1==0 || w2==0)
             hm{1,1}='none';
             hm{1,2}=0;
             hl{iz2,1}=hm;
         else
            h1=H{1,1};
            d=strcmp(h1,H);
            d1=find(d);
            H(d)=[];
            hm{1,1}=h1;
            hm{1,2}=length(d1);
            hl{iz2,1}=hm;
         end
        end
        jadval1{1,iz1}=hl;
    end
    jadval{1,iz0}=jadval1;
end
jadval2=cell(1,p2);

%halghe iz0 baraye har marhalast
for iz0=1:5
    row1=cell(1,1);
    row1=Ttx(2,iz0);
    M=row1{1,1};
    [OP,~]=size(M);
    %halghe iz1 baraye por kardane sutun haye jadval dar har
    %marhalast
    for iz1=1:p2
        hx=halat(iz1);
        hl=cell(hx,1);
        H=cell(1,1);
        H=M(:,o2(iz1));
        %halghe zir baraye har halate har vizhegi ast
        for iz2=1:hx   
         [w1,w2]=size(H);
          hm=cell(1,2);
         if(w1==0 || w2==0)
             hm{1,1}='none';
             hm{1,2}=0;
             hl{iz2,1}=hm;
             
         else
            h2=H{1,1};
            d=strcmp(h2,H);
            d1=find(d);
            H(d)=[];
            hm{1,1}=h2;
            hm{1,2}=length(d1);
            hl{iz2,1}=hm;
         end
        end
        jadval2{1,iz1}=hl;
    end
    jadval{2,iz0}=jadval2;
end

tree=cell(6,p1+p2);
finaler=zeros(5,p1+p2);
%sakht derakht:
for i0=1:iz0
    w1=jadval{1,i0};
    w2=jadval{2,i0};
    %agar vizhegi nominal bashad:
     for i=1:p2
         u1=w1{1,i};
         u2=w2{1,i};
         U=nomtree(u1,u2,PR1,PR2);
           finaler(i0,i)=U{end,1};
         tree{i0,i}=U;
         
         
     end
     p=1;
     [o,~]=size(train);
     hd=floor((1/10)*o);
     %agar vizhegi numeric bashad:
     for k1=p2+1:p1+p2

       Q=Tt{1,i0};
       V=Q(:,o1(p));
       V=cell2mat(V);
       J=Q(:,end);
       %treenum game 1 ra midahad.treenumr game 2 ra midahad.
       c=treenum(V,J);
       A=treenumr(c,hd,PR1,PR2);
       p=p+1;
     finaler(i0,k1)=A{end,1};

    tree{i0,k1}=A;

     end
 
end
for i2=1:p2
    tree{6,i2}=esm{1,o2(i2)};
end
for i2=1:p1
    tree{6,p2+i2}=esm{1,o1(i2)};
end
finaltree=cell(5,2);
for i=1:5
b=finaler(i,:);
[~,is]=find(min(b)==b);
finaltree{i,1}=tree{i,is(1)};
finaltree{i,2}=tree{6,is(1)};
end
%actual label 
W=Tt(2,:);
actuallabel=cell(1,5);
for i=1:5
    v=W{1,i};
    actuallabel{1,i}=v(:,end);
end
%predictlabel
predictlabel=cell(1,5);
plb=cell(x,1);
for i=1:5
    model=finaltree{i,1};
    feature=finaltree{i,2};
    ind=find(strcmp(esm,feature));
    v=W{1,i};
    v=v(:,ind);
    if(ismember(ind, o1))
    for j=1:x
        lb=v{j};
        baz=model(:,2);
        s=length(baz);
        for j4=1:s-1
        a=baz(j4);
        a=a{1};
        t=a(1):0.0001:a(2);
        if(ismember(lb,t))
            break;
        end
        end
        plb{j,1}=model{j4,1};
    end
    else
        for j1=1:x
           lb=v{j1};
           baz=model(:,2);
           f=length(baz);
           for j2=1:f-1
             b=baz{j2};
             if(strcmp(lb,b))
           indx=j2;
           break
             end
        end
        plb{j1,1}=model{indx,1};

    
        end
    end

    predictlabel{1,i}=plb;
  
end
testeror=zeros(1,5);
er=0;
for i=1:5
    s=predictlabel{1,i};
    t=actuallabel{1,i};
    for j=1:x
       a=s{j};
       b=t{j};
       er=er+ham(a,b);
    end
    testeror(1,i)=er;
    er=0;
    
end
   testeror=testeror/x;
   mianginkhata=mean(testeror);
   clearvars -except mianginkhata finaltree predictlabel actuallabel testeror
   
   
   
   
        
    
    
