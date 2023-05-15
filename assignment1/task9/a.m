
load "D:/magma/Magma/assignment1/task7/task6.m";
load "D:/magma/Magma/assignment1/task7/a.m";


DiseqSignForge:=function(A,mess)
    lamda:=127;
    ZN:=Parent(A[1,1]);
    m:=NumberOfRows(A);
    n:=NumberOfColumns(A);
    
    CiSeq:=[];
    MiSeq:=[];
    miSeq:=[];
    for i in [1..lamda] do
        repeat
            flag:=true;
            mi:=RandomMatrix(ZN,n,1);
            Ci:=RandomMatrix(ZN,m,m);
            Ctrunci:=Submatrix(Ci,1,1,n,n);
            Mi:=Ci*A*Ctrunci;
            Mmi:=Mi*mi;
            //check Mmi != 0
            for i in [1..m] do
                if Mmi[i,1] eq 0 then 
                    flag:=false;
                    break i;
                end if;
            end for;
        until flag;
        Append(~CiSeq, Ci);
        Append(~MiSeq, Mi);
        Append(~miSeq, mi);
    end for;
    
    AM:=Sprint(A);
    AM:= AM cat mess;
    for i in [1..lamda] do
        AM:=AM cat Sprint(MiSeq[i]);
    end for;
    c:=FakeHash(AM);

    
    sig:=<>;
    for i in [1..lamda] do
        if c[i] eq 0 then
            Append(~sig, MiSeq[i]);
            Append(~sig, CiSeq[i]);
        else
            Append(~sig, MiSeq[i]);
            Append(~sig, miSeq[i]);
        end if;
    end for;

    return sig;
end function;

/*
//test
s,A:=KeyGen(6, 30);
mess:="I will pay 10000 EUR to Eve. Best wishes, Peggy";
sig:=DiseqSignForge(A, mess);
*/