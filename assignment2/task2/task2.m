//2.a
DGHVKeyGen:=function(eta, gamma, N) //DGHVKeyGen(eta::RngIntElt, gamma::RngIntElt, N::RngIntElt) ->p::RngIntElt, x0::RngIntElt
    
    repeat
        p:=Random(N^(eta-1)+1,N^eta-1);
    until Gcd(p,N) eq 1;
    q0:=Random(1,Floor(N^gamma/p));
    x0:=p*q0;
    return p, x0, q0;
end function;

/*
//test 2.a
//load "D:/magma/Magma/assignment2/task2/task2.m";
p,x0,q0:=DGHVKeyGen(6,6,8);
p;
x0;
q0;
Type(p);
Type(x0);
*/

//2.b
DGHVEncrypt:=function(m, N, p, rho, gamma) //DGHVEncrypt(m::RngIntElt, N::RngIntElt, p::RngIntElt, rho::RngIntElt, gamma::RngIntElt) -> c::RngIntElt
    if  m lt 0 or m ge N then
        error "Error in 'DGHVEncrypt': m is not in [0...N-1]";
    end if;
    r:=Random(-N^rho+1,N^rho-1);
    q:=Random(0,Floor(N^gamma/p));
    c:=p*q+N*r+m;
    return c;
end function;

/*
//test 2.b
//load "D:/magma/Magma/assignment2/task2/task2.m";
p,x0,q0:=DGHVKeyGen(6,6,8);
m:=6;
c:=DGHVEncrypt(6,8,p,2, 6);
c;
Type(c);
*/


//2.c
DGHVDecrypt:=function(c, N, p) //DGHVDecrypt(c::RngIntElt, N::RngIntElt, p::RngIntElt) -> m::RngIntElt
    c_prime:=c mod p;
    c_prime:= c_prime;
    if c_prime gt p/2 then
        c_prime-:=p;
    end if;
    m:=c_prime mod N;
    return m;
end function;

/*
//test 2.c
//load "D:/magma/Magma/assignment2/task2/task2.m";
eta:=6;
gamma:=6;
rho:=2;
N:=8;
p,x0,q0:=DGHVKeyGen(eta,gamma,N);
m:=5;
c:=DGHVEncrypt(m,N,p,rho, gamma);
mm:=DGHVDecrypt(c, N, p);
mm;
Type(mm);
*/

//task 2.d
DGVHAdd:=function(c1, c2, x0) // DGHVAdd(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt
    c3:=c1+c2;
    c3:=c3 mod x0;
    return c3;
end function;

/*
//test 2.d
//load "D:/magma/Magma/assignment2/task2/task2.m";
eta:=6;
gamma:=6;
rho:=2;
N:=8;
p,x0,q0:=DGHVKeyGen(eta,gamma,N);
m1:=5;
m2:=2;
c1:=DGHVEncrypt(m1,N,p,rho, gamma);
c2:=DGHVEncrypt(m2,N,p,rho, gamma);
c:=DGVHAdd(c1,c2,x0);
mm:=DGHVDecrypt(c, N, p);
mm;
Type(mm);
*/

//task 2.e
DGHVMult:=function(c1,c2,x0) //DGHVMult(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt
    c4:=c1*c2;
    c4:=c4 mod x0;
    return c4;
end function;

/*
//test 2.e
//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task2/task2.m";
eta:=10;
gamma:=10;
rho:=2;
N:=8;
p,x0,q0:=DGHVKeyGen(eta,gamma,N);
m1:=5;
m2:=2;
c1:=DGHVEncrypt(m1,N,p,rho, gamma);
c2:=DGHVEncrypt(m2,N,p,rho, gamma);
c:=DGHVMult(c1,c2,x0);
mm:=DGHVDecrypt(c, N, p);
mm;
Type(mm);
*/

//task 2.f
DGHVNoiseTerm:=function(c, N, p) //DGHVNoiseTerm(c::RngIntElt, N::RngIntElt, p::RngIntElt) -> r::RngIntElt
    c_prime:=c mod p;
    c_prime:= c_prime;
    if c_prime gt p/2 then
        c_prime-:=p;
    end if;
    m:=c_prime mod N;
    rN:=c_prime - m;
    r:=rN/N;
    return r;
end function;

/*
//test 2.f  and verification of my bound
//load "D:/magma/Magma/assignment2/task2/task2.m";
eta:=11;
gamma:=11;
rho:=2;
N:=13;
k:=6;
Z:=Integers();
p,x0,q0:=DGHVKeyGen(eta,gamma,N);
mi:=[Random(0,N-1) : i in [1..k]];
mmulti:=[Z ! (mi[1]*mi[2] mod N)];
for i in [3..k] do
    Append(~mmulti,Z ! (mi[i]*mmulti[i-2] mod N));
end for;
ci:=[DGHVEncrypt(mi[i],N,p,rho, gamma) : i in [1..k]];
ri:=[DGHVNoiseTerm(ci[i],N,p) : i in [1..k]];
rmulti:=[N*ri[1]*ri[2]];
for i in [3..k] do
    Append(~rmulti, rmulti[i-2]*ri[i]*N);
end for;

c:=DGHVMult(ci[1],ci[2],x0);
r:=[DGHVNoiseTerm(c,N,p)];
mm:=[DGHVDecrypt(c,N,p)];
for i in [3..k] do
    c:=DGHVMult(c,ci[i],x0);
    Append(~r,DGHVNoiseTerm(c,N,p));
    Append(~mm,DGHVDecrypt(c,N,p));
end for;
print r;
print rmulti;
Floor(p/2) gt Abs(r[3]*N+N);
Floor(p/2) gt Abs(r[4]*N+N);
Floor(p/2) gt Abs(r[5]*N+N);
correctdec:=[mmulti[i] eq mm[i]: i in [1..k-1]];
print correctdec;
mmulti;
mm;
mi;
*/