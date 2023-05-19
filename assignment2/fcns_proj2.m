//Zirui Yan
//r0916941

DGHVKeyGen:=function(eta, gamma, N) //DGHVKeyGen(eta::RngIntElt, gamma::RngIntElt, N::RngIntElt) ->p::RngIntElt, x0::RngIntElt
    
    repeat
        p:=Random(N^(eta-1)+1,N^eta-1);
    until Gcd(p,N) eq 1;
    q0:=Random(1,Floor(N^gamma/p));
    x0:=p*q0;
    return p, x0, q0;
end function;


//2.b
DGHVEncrypt:=function(m, N, p, rho, gamma) //DGHVEncrypt(m::RngIntElt, N::RngIntElt, p::RngIntElt, rho::RngIntElt, gamma::RngIntElt) -> c::RngIntElt
    if  m lt 0 or m ge N then
        error "Error in 'DGHVEncrypt': m is not in [0...N-1]";
    end if;
    r:=Random(-N^rho+1,N^rho-1);
    q:=Random(0,Floor(N^gamma/p));
    c:=p*q+N*r+m;
    return c;
end function;


//2.c
DGHVDecrypt:=function(c, N, p) //DGHVDecrypt(c::RngIntElt, N::RngIntElt, p::RngIntElt) -> m::RngIntElt
    c_prime:=c mod p;
    c_prime:= c_prime;
    if c_prime gt p/2 then
        c_prime-:=p;
    end if;
    m:=c_prime mod N;
    return m;
end function;


//task 2.d
DGVHAdd:=function(c1, c2, x0) // DGHVAdd(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt
    c3:=c1+c2;
    c3:=c3 mod x0;
    return c3;
end function;


//task 2.e
DGHVMult:=function(c1,c2,x0) //DGHVMult(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt
    c4:=c1*c2;
    c4:=c4 mod x0;
    return c4;
end function;


//task 2.f
DGHVNoiseTerm:=function(c, N, p) //DGHVNoiseTerm(c::RngIntElt, N::RngIntElt, p::RngIntElt) -> r::RngIntElt
    c_prime:=c mod p;
    c_prime:= c_prime;
    if c_prime gt p/2 then
        c_prime-:=p;
    end if;
    m:=c_prime mod N;
    rN:=c_prime - m;
    r:=rN/N;
    return r;
end function;

//task3
LatAttackDGHV:=function(eta, rho, ci)
    Z:=Integers();
    t:=#ci;
    B:=ZeroMatrix(Z,t,t);
    B[1,1]:=2^(rho+1);
    for i in [1..t-1] do
        B[i+1,i+1]:=-ci[1];
        B[1,i+1]:=ci[i+1];
    end for;

    L:=LatticeWithBasis(B);
    LL:=LLL(L);
    
    p:=Abs(Round(ci[1]/(((LL.1)[1])/(2^(rho+1)))));

    return p;

end function;

LatAttackDGHV2:=function(eta, rho, ci)
    Z:=Integers();
    t:=#ci;
    B:=ZeroMatrix(Z,t,t);
    B[1,1]:=2^(rho+1);
    for i in [1..t-1] do
        B[i+1,i+1]:=-ci[1];
        B[1,i+1]:=ci[i+1];
    end for;

    L:=LatticeWithBasis(B);
    LL:=BKZ(L,6);
    
    p:=Abs(Round(ci[1]/(((LL.1)[1])/(2^(rho+1)))));

    return p;

end function;


//task4
SystemXKeyGen:=function(lambda, alpha) //SystemXKeyGen(lambda::RngIntElt, alpha::RngIntElt) -> p1::RngIntElt,p2::RngIntElt, p3::RngIntElt, x0::RngIntElt

        repeat
            p1:=RandomPrime(lambda : Proof:=false);
        until p1 ge 2^(lambda-1);

        repeat 
            p2:=RandomPrime(lambda : Proof:=false);
        until p2 ne p1 and p2 ge 2^(lambda-1);

        repeat
            p3:=RandomPrime(alpha*lambda : Proof:=false);
        until p3 ge 2^(alpha*lambda-1);

    x0:=p1*p2*p3;
    return p1,p2,p3,x0;
end function;

SystemXEncrypt:=function(m,p1,p2,p3)//SystemXEncrypt(m::RngIntElt, p1::RngIntElt, p2::RngIntElt, p3::RngIntElt)-> c::RngIntElt
    if  m lt 0 or m ge p1 then
        error "Error in 'SystemXEncrypt': m is not in [0...p-1]";
    end if;

    Z := Integers();
    Fp3 := Integers(p3);

    r := Random(0,p2-1); 
    e := CRT([m, r], [p1, p2]);
    N := p1*p2;

    MatEnc := Matrix(Z,2,2,[[N, 0], [e, 1]]);
    LEnc := Lattice(MatEnc);
    
    SV := LEnc.1;
    x := Fp3 ! SV[1];
    y := Fp3 ! SV[2];

    c := Z ! (x/y);



    return c;
end function;


SystemXDecrypt:=function(c, p1, p3) //SystemXDecrypt(c::RngIntElt, p1::RngIntElt, p3::RngIntElt) ->m::RngIntElt
    Z := Integers();
    Fp1 := Integers(p1);
    
    c_prime := Z ! (c mod p3);

    MatDec := Matrix(Z,2,2,[[p3, 0], [c_prime, 1]]);
    LDec := Lattice(MatDec);
    SV := LDec.1;

    x := Fp1 ! SV[1];
    y := Fp1 ! SV[2];
    m := Z ! (x/y);

    return m;

end function;


SystemXAdd:=function(c1, c2, x0)//SystemXAdd(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt
    c := c1 + c2;
    c := c mod x0;
    return c;
end function;

SystemXMult:=function(c1, c2, x0)//SystemXMult(c1::RngIntElt, c2::RngIntElt, x0::RngIntElt) -> c::RngIntElt

    c := c1 * c2;
    c := c mod x0;
    return c;
end function;

//task6
AttackSystemX:=function(lambda, alpha, cs, x0)
    Z:=Integers();
    p3:=0;
    Fx0 := Integers(x0);
    B := Matrix(Z,2,2,[[x0,0],[cs[1],1]]);
    L := Lattice(B);
    SV := L.1;
    p1p2xi := Z ! (Fx0 ! SV[1]);

    p1p2 := Gcd(p1p2xi, x0);

    p3 := Z ! (x0/p1p2);


    return p3;
end function;


//task7
function DecryptionOracle(c,p)
    return DGHVDecrypt(c, 2, p);
end function;

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
