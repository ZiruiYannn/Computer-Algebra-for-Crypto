WGenerate:=function(p)
    Fp:=GF(p);
    Fpx<x,y>:=PolynomialRing(Fp,2);
    f:=0*x;
    for i in [0..p-1] do
        for j in [0..p-1] do
            if i+j ge p then
                c:=Fp!i;
                d:=Fp!j;
                f:=f+((x-c)^(p-1) - 1)*((y-d)^(p-1) - 1);
            end if;
        end for;
    end for;
    return f;
end function;

DigitExtract:=function(c) //DigitExtract(c::RngIntResElt) -> FldFinElt, FldFinElt;
    Zp2:=Parent(c);
    p2:=Characteristic(Zp2);
    fact:=Factorization(p2);
    p:=fact[1][1]; //fact:=[<p,2>]
    Z:=Integers();
    c:=Z!c;
    c0:=c mod p;
    c1:=(c-c0) div p;
    Fp:=GF(p);
    return Fp!c0, Fp!c1;
end function;



FromDiseqToEq2:=function(a,b)
    Zp2:=Parent(a[1]);
    p2:=#Zp2;
    fact:=Factorization(p2);
    p:=fact[1][1]; //fact:=[<p,2>]
    W:=WGenerate(p);

    b0,b1:=DigitExtract(-b); // we should get the negative b at first

    Fp:=GF(p);
    n:=#a;
    Fpx:=PolynomialRing(Fp,2*n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f0:=0*Fpx.1;
    f1:=0*Fpx.1;
    for i in [1..n] do 
        for  j in [1..(Integers() ! a[i])] do
            f1+:=Fpx.(2*i) + Evaluate(W,[f0,Fpx.(2*i-1)]); // the order is important, f1 should be changed first
            f0+:=Fpx.(2*i-1);
        end for;
    end for;
    f1+:= b1 + Evaluate(W,[f0,b0]); 
    f0+:= b0;
    return (f0^(p-1)-1)*(f1^(p-1)-1),f0,f1;
end function;


print("test 3c");
//test 1
Zp2:=Integers(2^2);
a:=[Zp2|0,3];
b:=Zp2 ! 1;

f,f0,f1:=FromDiseqToEq2(a,b);

x:=[Zp2|0,3];
xx:=[];
for xi in x do 
    xi0,xi1:=DigitExtract(xi);
    xx:=Append(xx, xi0);
    xx:=Append(xx, xi1);
end for;

&+[(a[i]*x[i]) : i in [1..(#a)]] ne b;
Evaluate(f,xx);

//test2
Zp2:=Integers(7^2);
a:=[Zp2|41,23];
b:=Zp2 ! 14;

f,f0,f1:=FromDiseqToEq2(a,b);

x:=[Zp2|20,31];
xx:=[];
for xi in x do 
    xi0,xi1:=DigitExtract(xi);
    xx:=Append(xx, xi0);
    xx:=Append(xx, xi1);
end for;

&+[(a[i]*x[i]) : i in [1..(#a)]] ne b;
Evaluate(f,xx);