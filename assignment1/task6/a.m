//copy from task1
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


//test
N:=6;
n:=30;
s,A:=KeyGen(N,n);
A*s;

