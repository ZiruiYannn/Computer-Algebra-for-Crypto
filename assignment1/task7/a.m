FakeHash:=function(string) //FakeHash(string::MonStgElt) -> SeqEnum
    p:=2^127-1;
    Fp:=GF(p);
    Z:=Integers();
    h:=Fp ! 43;
    n:=#string;
    for i in [1..n] do 
        ascii:=StringToCode(string[i]);
        h:=h ^ (ascii+1) + 1;
    end for;
    return Intseq(Z ! h,2,127);
end function;

/*
//test
s:="Hello";
H:=FakeHash(s);
#H;
H;
*/