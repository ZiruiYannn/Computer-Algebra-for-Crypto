Response:=function(c, s, C) //Response(c::RngIntElt, s::ModMatRngElt, C::ModMatRngElt) -> ModMatRngElt
    if c eq 0 then
        return C;
    else 
        if c eq 1 then 
            ZN:=Parent(s[1,1]);
            n:=NumberOfRows(s);
            Ctrunc:=ZeroMatrix(ZN,n,n);
            for i in [1..n] do 
                for j in [1..n] do
                    Ctrunc[i,j]:=C[i,j];
                end for;
            end for;
            return Ctrunc^(-1) * s;
        end if;
    end if;
end function;