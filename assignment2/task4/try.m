//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/try.m";

clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/task4.m";

lambda:=12;
alpha:=5;

p1,p2,p3,x0:=SystemXKeyGen(lambda, alpha);

    m:=Random(p1-1);


Z := Integers();
    Fp3 := Integers(p3);

    r := Random(0,p2-1); 
    e := CRT([m, r], [p1, p2]);
    N := p1*p2;

    MatEnc := Matrix(Z,2,2,[[N, 0], [e, 1]]);
    LEnc := Lattice(MatEnc);
    
    SVe := LEnc.1;
    x := Fp3 ! SVe[1];
    y := Fp3 ! SVe[2];

    c := Z ! (x/y);

    Z := Integers();
    Fp1 := Integers(p1);
    
    c_prime := Z ! (c mod p3);

    MatDec := Matrix(Z,2,2,[[p3, 0], [c_prime, 1]]);
    LDec := Lattice(MatDec);
    
    SVd := LDec.1;

    x := Fp1 ! SVd[1];
    y := Fp1 ! SVd[2];
    mm := Z ! (x/y);

m eq mm;

x/y;
c;