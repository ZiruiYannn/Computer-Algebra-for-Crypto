//Ex2 Construct a finite field with 31 elmts, and write a for loop that verifies Fermat's little theorem

Z:=Integers();
N:=31;
ZN:=Integers(N);

flag:=true;
for a in ZN do
    if a^N ne a then flag:=false; end if;
end for;


flag;

//Construct a polyn. ring over finite field of 31 elmts with variable name x.



//generate random monic irreducible polyn..

n:=10;

GenRandomIrreduciblePol:=function(Fp,degree)
    Fpx:=PolynomialRing(Fp);
    repeat y:=Fpx ! [Random(Fp) : i in [1..degree]];
    until IsIrreducible(y);
    return y;
end function;

p:=GenRandomIrreduciblePol(ZN,n);
p;