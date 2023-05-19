
for i:= 1 to 5 do
    if IsOdd(i) then print i^2;end if;
end for;

A:=[1..20];
B:=[5..8];
print 5 notin A;
print #A;
print A cat B;

print &+A;

8 ne 7;
7 ne 7;

C:=[false, true, false];

print &and C;

a:=6;
b:=3;
c:=Integers() ! (a/b);
print Type(c);
GF(c);

Z:=Integers();
Q:=Rationals();
R:=RealField(10);
Fp:=GF(7);
ZN:=Integers(15);

//p:=RandomPrime(2000 : Proof := false);
//print p;

//Z:=Integers();
Z:=GF(7);
Zx<x>:=PolynomialRing(Z);
f:=x^3-3*x+7;
print f;
print Roots(f);

Zxy<x,y>:=PolynomialRing(Z,2);
f:=x^2*y^2+3*y^2;
print Factorisation(f);



//Alternative:
Z:=Integers();
Zxy:=PolynomialRing(Z,2);
f:=Zxy.1^2+Zxy.2^2+3*Zxy.2^2;
print Factorisation(f);

Z:=Integers();
Zx<x>:=PolynomialRing(Z);
f:=Zx ![-3, 0, 2, 1, 5];
print f;
print Eltseq(f);



Z:=Integers();
ZN:=Integers(8);
a:=Random(ZN);
b:=ZN ! 11;

Fp<alpha>:=GF(7^4);
SetPowerPrinting(Fp,false);
a:=Random(Fp);
print  a;



Fpx<x>:=PolynomialRing(Fp);
f:=Fpx ! [Random(Fp) : i in [1..5]];
print f;
print Roots(f);