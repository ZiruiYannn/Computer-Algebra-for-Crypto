//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task4/task4.m";

//5.a
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
