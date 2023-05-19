//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task3/testb.m";

clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task2/task2.m";
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task3/task3.m";

eta:=400;
rho:=20;
gamma:=1000;
N:=2;
Z:=Integers();
count:=0;
num:=1;
t:=50;


flag:=true;
flag2:=true;

repeat
    p,x0,q0:=DGHVKeyGen(eta,gamma,N);

    mi:=[Random(0,N-1) : i in [1..t]];
    ci:=[DGHVEncrypt(mi[i],N,p,rho, gamma) : i in [1..t]];

    t:=Cputime();
    pp:=LatAttackDGHV(eta,rho, ci);
    print Cputime(t);
    /*
    t2:=Cputime();
    ppp:=LatAttackDGHV2(eta,rho, ci);
    print Cputime(t2);
*/
    if p ne pp then
        flag:=false;
        /*
        if ppp ne p then 
            flag2:=false;
        end if;
        */
        break;
    end if;
/*
    if ppp ne p then 
        flag2:=false;
        break;
    end if;
*/
    count+:=1;

until count ge num;

print flag, flag2,count;
pp;
//ppp;