function A=treenum(V,J)
 i=1;
l=length(V);
A=cell(2,i);
V=sort(V);
while(i<=l)
    a1=V(i);
    [~,j]=find(V==a1);
    j1=length(j);
    for s0=i:i+j1-1
        A{1,s0}=a1;
    end
        p=1;
    for s1=i:i+j1-1
    A{2,s1}=J{p};
    p=p+1;
    end
    i=i+j1;
end
end