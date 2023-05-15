Verify:=function(c, A, M, resp) //Verify(c::RngIntElt, A::ModMatRngElt, M::ModMatRngElt, resp:ModMatRngElt)-> BoolElt 
    flag:=true;
    if c eq 0 then 
        ZN:=Parent(A[1][1]);
        C:=resp;
        n:=NumberOfColumns(A);
        Ctrunc:=ZeroMatrix(ZN,n,n);
        for i in [1..n] do 
            for j in [1..n] do
                Ctrunc[i,j]:=C[i,j];
            end for;
        end for;
        if M eq C*A*Ctrunc then
            
        else 
            flag:=false;
        end if;
    else
        if c eq 1 then
            Mm:=M*resp;
            m:=NumberOfRows(M);
            for i in [1..m] do
                if Mm[i,1] eq 0 then 
                    flag:=false;
                end if;
            end for;
        end if;
    end if;
    return flag;
end function;