clear;

load "D:/magma/Magma/assignment1/task6/a.m";
load "D:/magma/Magma/assignment1/task6/b.m";
load "D:/magma/Magma/assignment1/task6/c.m";
load "D:/magma/Magma/assignment1/task6/d.m";
C,M,CC,CCC:=Commit(s, A);
Z2:=Integers(2);
resp:=Response(Z2 ! 1, s, C);

Verify(Z2 ! 1, A, M, resp);