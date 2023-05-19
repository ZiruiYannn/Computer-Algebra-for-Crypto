FromDiseqToEq:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    n:=#a;
    Fpx:=PolynomialRing(Fp,n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f:=(&+[(a[i]*Fpx.i) : i in [1..n]] - b)^(p-1)-1;
    return f;
end function;

//test
F3:=FiniteField(7);
a:=[F3|1,1,0];
b:=2;
f:=FromDiseqToEq(a,b);

print f;

x:=[F3|1,2,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);

x:=[F3|2,2,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);