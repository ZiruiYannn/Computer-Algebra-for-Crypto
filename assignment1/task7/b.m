clear;
load "D:/magma/Magma/assignment1/task7/task6.m";
load "D:/magma/Magma/assignment1/task7/a.m";

DiseqSign:=function(s, A, mess)
    lamda:=127;
    
    CiSeq:=[];
    MiSeq:=[];
    for i in [1..lamda] do
        Ci, Mi:=Commit(s, A);
        Append(~CiSeq,Ci);
        Append(~MiSeq,Mi);
    end for;
    
    AM:=Sprint(A);
    AM:= AM cat mess;
    for i in [1..lamda] do
        AM:=AM cat Sprint(MiSeq[i]);
    end for;
    c:=FakeHash(AM);

    
    sig:=<>;
    for i in [1..lamda] do
        Append(~sig, MiSeq[i]);
        respi:=Response(c[i], s, CiSeq[i]);
        Append(~sig, respi);
    end for;

    return sig;

end function;

/*
//test
s,A:=KeyGen(6, 30);
mess:="I will pay 10 EUR to Victor. Best wishes, Peggy";
sig:=DiseqSign(s, A, mess);
*/