//AttackSystemX(lambda::RngIntElt, alpha::RngIntElt, cs::SeqEnum(RngIntElt),x0::RngIntElt) -> p3::RngIntElt

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