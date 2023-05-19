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


DigitMerge:=function(c0,c1) //DigitMerge(c0::FldFinElt, c1::FldFinElt) -> RngIntResElt;
    Fp:=Parent(c0);
    p:=Characteristic(Fp);
    Z:=Integers();
    Zp2:=Integers(p^2);
    c:=Zp2!(Z!c0 + p * Z!c1);
    return c;
end function;



//test WGenerate
c:=4;
d:=0;
p:=7;
f:=WGenerate(p);
print("c:");
c;
print("d:");
d;
print("p:");
p;
print("W:");
Evaluate(f,[c,d]);



//test DigitExtract
print("test DigitExtract");
p:=7;
Zp2:=Integers(p^2);
c:=Random(Zp2);
c0,c1:=DigitExtract(c);
print("c:");
c;
print("c0:");
c0;
print("c1:");
c1;


//test DigitMerge
Fp:=GF(7);
c0:=Fp!3;
c1:=Fp!6;
c:=DigitMerge(c0,c1);
print("test DigitMerge");
c;