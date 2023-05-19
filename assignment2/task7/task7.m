//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task7/task7.m";


DGHVDecrypt:=function(c, N, p) //DGHVDecrypt(c::RngIntElt, N::RngIntElt, p::RngIntElt) -> m::RngIntElt
    c_prime:=c mod p;
    c_prime:= c_prime;
    if c_prime gt p/2 then
        c_prime-:=p;
    end if;
    m:=c_prime mod N;
    return m;
end function;

function DecryptionOracle(c,p)
    return DGHVDecrypt(c, 2, p);
end function;



//ActAttackDGHV(p::RngIntElt)-> n::RngIntElt
ActAttackDGHV:=function(p)
    Z:=Integers();
    c2:=1;
    repeat
        c2:=2*c2;
        m2:=DecryptionOracle(c2,p);
    until m2 ne 0;

    c1:=c2/2; //c1 is even unless c2 is 2
    repeat
        c3:=Floor((c1+c2)/2);
        if IsOdd(c3) then
            c3+:=1;
        end if;
        m3:=DecryptionOracle(c3,p);
        if m3 eq 0 then
            c1:=c3;
        else
            c2:=c3;
        end if;
    until c1+2 eq c2;
    m4:=DecryptionOracle(Z ! ((c1+c2)/2),p);
    if  m4 eq 1 then
        n:=c2*2-1;
    else
        n:=c1*2+1;
    end if;
    return n;
end function;