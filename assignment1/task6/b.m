///////////
//Attention: output is AlgMatElt not ModMatRngElt
///////////

Commit:=function(s,A) //Commit(s::ModMatRngElt, A::ModMatRngElt) -> ModMatRngElt, ModMatRngElt
    ZN:=Parent(s[1,1]);
    m:=NumberOfRows(A);
    n:=NumberOfColumns(A);
    repeat
        flag:=true;
        flag;
        C:=RandomMatrix(ZN,m,m);
        Ct:=C*A*s;
        Ctrunc:=ZeroMatrix(ZN,n,n);
        for i in [1..n] do 
            for j in [1..n] do
                Ctrunc[i,j]:=C[i,j];
            end for;
        end for;
        //check Ct != 0
        for i in [1..m] do
            if Ct[i,1] eq 0 then 
                flag:=false;
                flag;
            end if;
        end for;
        //check Ctrunc
        if IsUnit(Ctrunc) then
        else
            flag:=false;
            flag;
        end if;
    until flag;
    //AlgMatElt to ModMatRngElt
    C:=RMatrixSpace(ZN,m,m) ! C;
    Ctrunc:=RMatrixSpace(ZN,n,n) ! Ctrunc;
    return C, C*A*Ctrunc;
end function;