function A=nomtree(x,y,PR1,PR2)
r=size(x);
r=r(1);
A=cell(r+1,1);
er=0;
for i=1:r
    e1=x{i,1};
    e2=y{i,1};
    j1=e1{1,2};
    j2=e2{1,2};
    if(j1>j2)
        A{i,1}=PR1;
        A{i,2}=e1{1};
        er=er+j2;
    else
        A{i,1}=PR2;
        A{i,2}=e1{1};

        er=er+j1;
    end
end
A{r+1,1}=er;
end