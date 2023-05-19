//copy from task2(b)
FromDiseqToEq:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    n:=#a;
    Fpx:=PolynomialRing(Fp,n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f:=(&+[(a[i]*Fpx.i) : i in [1..n]] - b)^(p-1)-1;
    return f;
end function;

FromDiseqToLinEq:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    f:=FromDiseqToEq(a,b);
    Fpx:=Parent(f);
    i:=p-1;
    seq:=[];
    repeat 
        for m in MonomialsOfDegree(Fpx,i) do
            seq:=Append(seq,MonomialCoefficient(f,m));
        end for;
        i:=i-1;
    until i le 0;
    M:=Matrix([seq]);
    Cterm:=MonomialCoefficient(f,1);
    return M, Cterm;
end function;


//test
F3:=FiniteField(4);
a:=[F3|1,1,0];
b:=2;
f:=FromDiseqToEq(a,b);

print f;

coeffs, C:=FromDiseqToLinEq(a,b);
coeffs;
C;