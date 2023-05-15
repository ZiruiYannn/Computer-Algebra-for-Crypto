
load "D:/magma/Magma/assignment1/task7/task6.m";
load "D:/magma/Magma/assignment1/task7/a.m";

VerifySign:=function(sig, A, mess)
    flag:=true;
    lamda:=127;
    AM:=Sprint(A);
    AM:= AM cat mess;
    for i in [1..lamda] do
        AM:=AM cat Sprint(sig[2*i-1]);
    end for;
    c:=FakeHash(AM);

    for i in [1..lamda] do
        v:=Verify(c[i],A,sig[2*i-1],sig[2*i]);
        if not(v) then
            flag:=false;
            break i;
        end if;
    end for;
    return flag;
end function;

