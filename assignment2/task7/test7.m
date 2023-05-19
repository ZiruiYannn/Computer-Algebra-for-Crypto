//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task7/test7.m";

clear;
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task2/task2.m";
load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task7/task7.m";

eta:=1000;
rho:=100;
gamma:=3000;
N:=2;
Z:=Integers();
count:=0;
num:=30;
t:=50;


flag:=true;

repeat
    p,x0,q0:=DGHVKeyGen(eta,gamma,N);


    //t:=Cputime();
    
    pp:=ActAttackDGHV(p);
    //print Cputime(t);

    if p ne pp then
        flag:=false;
        break;
    end if;
    count+:=1;

until count ge num;

print flag, count;
p;
pp;
