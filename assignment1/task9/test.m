load "D:/magma/Magma/assignment1/task7/task6.m";
load "D:/magma/Magma/assignment1/task7/a.m";
load "D:/magma/Magma/assignment1/task9/a.m";
load "D:/magma/Magma/assignment1/task7/c.m";

s,A:=KeyGen(6, 30);
mess:="I will pay 10000 EUR to Eve. Best wishes, Peggy";
sig:=DiseqSignForge(A, mess);
VerifySign(sig, A, mess);