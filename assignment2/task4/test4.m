//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/test4.m";

clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/task4.m";

/*
print "test 5.a SystemXKeyGen";

lambda:=256;
alpha:=3;

for i in [1..30] do
    p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);
    print x0;
    print Log(2,p1),Log(2,p2),Log(2,p3);
    print Type(p1),Type(p2),Type(p3),Type(x0);
end for;
*/

/*
print "test 5.b SystemXEncrypt";

lambda:=256;
alpha:=3;

for i in [1..30] do
    p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);

    m:=Random(p1-1);

    c:=SystemXEncrypt(m,p1,p2,p3);

    print Type(c);
    print Log(2,c), Log(2,p3);
    print c ge 0, c lt p3;
end for;
*/

/*
print "test 5.c SystemXEncrypt";

lambda:=128;
alpha:=5;


for i in [1..30] do
    p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);

    m:=Random(p1-1);

    c:=SystemXEncrypt(m,p1,p2,p3);
    mm:=SystemXDecrypt(c,p1,p3);

    print m eq mm;
    if m ne mm then
        print p1,p2,p3,x0;
        print m, mm;
    end if;
    
end for;
*/

/*
print "test 5.d SystemXAdd";

lambda:=4;
alpha:=10;


for i in [1..10] do
    p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);

    m1:=Random(p1-1);
    m2:=Random(p1-1);

    c1:=SystemXEncrypt(m1,p1,p2,p3);
    c2:=SystemXEncrypt(m2,p1,p2,p3);

    c3:=SystemXAdd(c1,c2,x0);
    mm:=SystemXDecrypt(c3,p1,p3);

    print m1+m2 eq mm;
    if m1+m2 ne mm then
        print p1,p2,p3,x0;
        print m1,m2, mm;
    end if;
    
end for;
*/

/*
print "test 5.e SystemXMult";

lambda:=4;
alpha:=3;


for i in [1..10] do
    p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);

    m1:=Random(p1-1);
    m2:=Random(p1-1);

    c1:=SystemXEncrypt(m1,p1,p2,p3);
    c2:=SystemXEncrypt(m2,p1,p2,p3);

    c3:=SystemXMult(c1,c2,x0);
    mm:=SystemXDecrypt(c3,p1,p3);

    print m1*m2 eq mm;
    if m1*m2 ne mm then
        print p1,p2,p3,x0;
        print m1,m2, mm;
    end if;
    
end for;
*/




