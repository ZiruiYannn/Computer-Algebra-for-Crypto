RandomDiseq:=function(s,homog)
    n:=#s;
    R:=Parent(s[1]);
    if homog then
        repeat
            a:=[Random(R) : i in [1..n]];
        until &+[(a[i]*s[i]) : i in [1..n]] ne 0;
        return a, Zero(R);
    else
        repeat
            a:=[Random(R) : i in [1..n]];
            b:=Random(R);
            until &+[(a[i]*s[i]) : i in [1..n]] ne b;
        return a, b;
    end if;
end function;


KeyGen:=function(N,n) //KeyGen(N::RngIntElt, n::RngIntElt) -> ModMatRngElt, ModMatRngElt
    //TODO: change CN
    CN:=1;
    ZN:=Integers(N);
    s:=[Random(ZN) : i in [1..n]];

    m:=CN * n;

    A:=ZeroMatrix(ZN, m, n);
    for i in [1..m] do
        a,b:=RandomDiseq(s, true);
        for j in [1..n] do
            A[i,j]:=a[j];
        end for;
    end for;

    Mat_s:=ZeroMatrix(ZN, n, 1);

    for i in [1..n] do
        Mat_s[i,1]:=s[i];
    end for;

    return Mat_s, A;
end function;


Commit:=function(s,A) //Commit(s::ModMatRngElt, A::ModMatRngElt) -> ModMatRngElt, ModMatRngElt
    ZN:=Parent(s[1,1]);
    m:=NumberOfRows(A);
    n:=NumberOfColumns(A);
    repeat
        flag:=true;
        C:=RandomMatrix(ZN,m,m);
        Ct:=C*A*s;
        Ctrunc:=Submatrix(C,1,1,n,n);
        //check Ctrunc
        if not(IsUnit(Ctrunc)) then
            flag:=false;
        end if;
        //check Ct != 0
        for i in [1..m] do
            if Ct[i,1] eq 0 then 
                flag:=false;
                break i;
            end if;
        end for;
        
    until flag;
    
    C:=RMatrixSpace(ZN,m,m) ! C;
    Ctrunc:=RMatrixSpace(ZN,n,n) ! Ctrunc;
    return C, C*A*Ctrunc;
end function;


Response:=function(c, s, C) //Response(c::RngIntElt, s::ModMatRngElt, C::ModMatRngElt) -> ModMatRngElt
    if c eq 0 then
        return C;
    else 
        if c eq 1 then 
            ZN:=Parent(s[1,1]);
            n:=NumberOfRows(s);
            Ctrunc:=Submatrix(C,1,1,n,n);
            return Ctrunc^(-1) * s;
        end if;
    end if;
end function;


Verify:=function(c, A, M, resp) //Verify(c::RngIntElt, A::ModMatRngElt, M::ModMatRngElt, resp:ModMatRngElt)-> BoolElt 
    flag:=true;
    if c eq 0 then 
        ZN:=Parent(A[1][1]);
        C:=resp;
        n:=NumberOfColumns(A);
        Ctrunc:=Submatrix(C,1,1,n,n);
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