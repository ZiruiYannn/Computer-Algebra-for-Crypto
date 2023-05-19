//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task2/f.m";
clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task2/task2.m";

eta:=80;
gamma:=2000;
rho:=20;
N:=100;
k:=6;
Z:=Integers();

max_count:=1000;
count:=0;

true_num:=[0 : i in [1..k-1]];

repeat
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

    correctdec:=[mmulti[i] eq mm[i]: i in [1..k-1]];
    for i in [1..k-1] do
        if correctdec[i] eq true then 
            true_num[i]+:=1;
        end if;
    end for;

    count+:=1;

until count eq max_count;

print true_num;