load "D:/magma/Magma/assignment1/task7/task6.m";
load "D:/magma/Magma/assignment1/task7/a.m";
load "D:/magma/Magma/assignment1/task7/b.m";
load "D:/magma/Magma/assignment1/task7/c.m";

s,A:=KeyGen(6, 30);
mess:="I will pay 10 EUR to Victor. Best wishes, Peggy";
sig:=DiseqSign(s, A, mess);
VerifySign(sig, A, mess);