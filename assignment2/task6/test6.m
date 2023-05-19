//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task6/test6.m";

clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/task4.m";
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task6/task6.m";


lambda:=64;
alpha:=4;
t:=3;

repeat
p1,p2,p3,x0 := SystemXKeyGen(lambda, alpha);
cs := [];
cscount:=0;
repeat
    m := Random(p1-1);
    c:=SystemXEncrypt(m,p1,p2,p3);
    Append(~cs, c);
    cscount+:=1;
until cscount ge t;


count:=0;
t:=Cputime();

pp:=AttackSystemX(lambda,alpha,cs,x0);
print Cputime(t);
p3 eq pp;
count;
until false;


/*
Z:=Integers();
    pp:=0;
    for ci in cs do
    count+:=1;
        Fci := Integers(x0);
        B := Matrix(Z,2,2,[[x0,0],[ci,1]]);
        L := Lattice(B);
        SV := L.1;
        p1p2xi := Z ! (Fci ! SV[1]);

        p1p2 := Gcd(p1p2xi, x0);

        pp := Z ! (x0/p1p2);
        if IsPrime(pp) and pp ge 2^(alpha*lambda-1) then 
            print true; 
            break;
        end if;


    end for;
    */