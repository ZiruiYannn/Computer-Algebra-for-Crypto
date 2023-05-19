//task1 a 
RandomDiseq:=function(s,homog)
    n:=#s;
    R:=Parent(s[1]);
    if homog then
        repeat
            a:=[Random(R) : i in [1..n]];
        until &+[(a[i]*s[i]) : i in [1..n]] ne 0;
        k:=<>;
        for i in [1..n] do
            Append(~k,a[i]);
        end for;
        return k, Zero(R);
    else
        repeat
            a:=[Random(R) : i in [1..n]];
            b:=Random(R);
        //until &+[(a[i]*s[i]) : i in [1..n]] ne b and b ne 0;
        until &+[(a[i]*s[i]) : i in [1..n]] ne b;
        k:=<>;
        for i in [1..n] do
            Append(~k,a[i]);
        end for;
        return k, b;
    end if;
end function;

/*
//test task1 a
ZN:=Integers(7);
s:=<ZN!4,ZN!9,ZN!2,ZN!2>;
a,b:=RandomDiseq(s,true);
a;
b;
&+[(a[i]*s[i]) : i in [1..#s]] ne b;
a,b:=RandomDiseq(s,false);
a;
b;
&+[(a[i]*s[i]) : i in [1..#s]] ne b;
*/


//task1 b
Heuristic:=function(A,b,s,maxit)
    n:=#s;
    m:=#b;
    R:=Parent(s[1]);
    flag:=true;
    ss:=Matrix(R,n,1,s);
    for i in [1..maxit] do
        x:=RandomMatrix(R,n,1);
        Ax:=A*x;
        flag2:=true;
        for j in [1..m] do
            if Ax[j,1] eq b[j] then 
                flag2:=false;
                break j;
            end if;
        end for;

        if flag2 then 
            if x ne ss then 
                flag:=false;
                break i;
            end if;
        end if;
    end for;
    return flag,x;
end function;

/*
p:=2;
n:=10;
n_de:=20;
R:=Integers(p);
s:=[Random(R) : j in [1..n]];
A:=ZeroMatrix(R,n_de,n);
B:=[];
for i in [1..n_de] do
    a,b:=RandomDiseq(s,false);
    for j in [1..n] do 
        A[i,j]:=a[j];
    end for;
    Append(~B,b);
end for;
flag,x:=Heuristic(A,B,s,6000);
flag;
//x;
*/

//task2 b
FromDiseqToEq:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    n:=#a;
    Fpx:=PolynomialRing(Fp,n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f:=(&+[(a[i]*Fpx.i) : i in [1..n]] - b)^(p-1)-1;
    return f;
end function;

/*
//test task2 b
F3:=FiniteField(7);
a:=[F3|1,1,0];
b:=2;
f:=FromDiseqToEq(a,b);

print f;

x:=[F3|1,5,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);

x:=[F3|2,2,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);
*/

/*
//load "D:/magma/Magma/assignment1/final/ZiruiYan_r0916941.m";
//task2 c
r:=1;
n:=5;
p:=5;
CNn:=p*n;

Fp:=GF(p);
s:=[Random(Fp) : i in [1..n]];
Fpx:=PolynomialRing(Fp,n);
fs:=[];
t1:=0;
for i in [1..CNn] do 
    a,b:=RandomDiseq(s,false);
    t:=Cputime();
    f:=FromDiseqToEq(a,b);
    Append(~fs,f);
    t1+:=Cputime(t);
end for;
print "t1",t1;

for i in [1..n] do
    f:=Fpx.i^p-Fpx.i;
    Append(~fs,f);
end for;
t2:=Cputime();
I:=Ideal(fs);
V:=Variety(I);
print "t2", Cputime(t2);
V;
*/

/*
//task2 d
FromDiseqToEqNew:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    n:=#a;
    Fpx:=PolynomialRing(Fp,n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f:=(&+[(a[i]*Fpx.i) : i in [1..n]] - b)^EulerPhi(p)-1;
    return f;
end function;


//test task2 d
F3:=Integers(6);
a:=[F3|1,1,0];
b:=2;
f:=FromDiseqToEq(a,b);

print f;

x:=[F3|1,5,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);

x:=[F3|2,2,0];
&+[(a[i]*x[i]) : i in [1..3]] ne b;
Evaluate(f,x);
*/

//task3
WGenerate:=function(p)
    Fp:=GF(p);
    Fpx<x,y>:=PolynomialRing(Fp,2);
    f:=0*x;
    for i in [0..p-1] do
        for j in [0..p-1] do
            if i+j ge p then
                c:=Fp!i;
                d:=Fp!j;
                f:=f+((x-c)^(p-1) - 1)*((y-d)^(p-1) - 1);
            end if;
        end for;
    end for;
    return f;
end function;

DigitExtract:=function(c) //DigitExtract(c::RngIntResElt) -> FldFinElt, FldFinElt;
    Zp2:=Parent(c);
    p2:=Characteristic(Zp2);
    fact:=Factorization(p2);
    p:=fact[1][1]; //fact:=[<p,2>]
    Z:=Integers();
    c:=Z!c;
    c0:=c mod p;
    c1:=(c-c0) div p;
    Fp:=GF(p);
    return Fp!c0, Fp!c1;
end function;


DigitMerge:=function(c0,c1) //DigitMerge(c0::FldFinElt, c1::FldFinElt) -> RngIntResElt;
    Fp:=Parent(c0);
    p:=Characteristic(Fp);
    Z:=Integers();
    Zp2:=Integers(p^2);
    c:=Zp2!(Z!c0 + p * Z!c1);
    return c;
end function;


/*
//test WGenerate
c:=4;
d:=0;
p:=7;
f:=WGenerate(p);
print("c:");
c;
print("d:");
d;
print("p:");
p;
print("W:");
Evaluate(f,[c,d]);

//test DigitExtract
print("test DigitExtract");
p:=7;
Zp2:=Integers(p^2);
c:=Random(Zp2);
c0,c1:=DigitExtract(c);
print("c:");
c;
print("c0:");
c0;
print("c1:");
c1;

//test DigitalMerge
print("Merge");
DigitMerge(c0,c1);
*/


FromDiseqToEq2:=function(a,b)
    Zp2:=Parent(a[1]);
    p2:=#Zp2;
    fact:=Factorization(p2);
    p:=fact[1][1]; //fact:=[<p,2>]
    W:=WGenerate(p);

    b0,b1:=DigitExtract(-b); // we should get the negative b at first

    Fp:=GF(p);
    n:=#a;
    Fpx:=PolynomialRing(Fp,2*n); //Fpx<[x[i] : i in [1..n]]>:=PolynomialRing(Fp,n); is not correct
    f0:=0*Fpx.1;
    f1:=0*Fpx.1;
    for i in [1..n] do 
        for  j in [1..(Integers() ! a[i])] do
            f1+:=Fpx.(2*i) + Evaluate(W,[f0,Fpx.(2*i-1)]); // the order is important, f1 should be changed first
            f0+:=Fpx.(2*i-1);
        end for;
    end for;
    f1+:= b1 + Evaluate(W,[f0,b0]); 
    f0+:= b0;
    return (f0^(p-1)-1)*(f1^(p-1)-1);
    //return (f0^(p-1)-1)*(f1^(p-1)-1),f0,f1;
end function;

/*
//test task3 c
print("test 3c");
//testcase1
Zp2:=Integers(2^2);
a:=[Zp2|0,3];
b:=Zp2 ! 1;

f,f0,f1:=FromDiseqToEq2(a,b);

x:=[Zp2|0,3];
xx:=[];
for xi in x do 
    xi0,xi1:=DigitExtract(xi);
    xx:=Append(xx, xi0);
    xx:=Append(xx, xi1);
end for;

&+[(a[i]*x[i]) : i in [1..(#a)]] ne b;
Evaluate(f,xx);

//testcase2
Zp2:=Integers(7^2);
a:=[Zp2|41,23];
b:=Zp2 ! 14;

f,f0,f1:=FromDiseqToEq2(a,b);

x:=[Zp2|20,31];
xx:=[];
for xi in x do 
    xi0,xi1:=DigitExtract(xi);
    xx:=Append(xx, xi0);
    xx:=Append(xx, xi1);
end for;

&+[(a[i]*x[i]) : i in [1..(#a)]] ne b;
Evaluate(f,xx);
*/

/*
//task3 d
//load "D:/magma/Magma/assignment1/final/ZiruiYan_r0916941.m";
//task2 c
r:=4;
n:=3;
p:=4;
CNn:=p*n;

Fp:=Integers(p);
s:=[Random(Fp) : i in [1..n]];
Fpx:=PolynomialRing(Fp,n);
fs:=[];
t1:=0;
for i in [1..CNn] do 
    a,b:=RandomDiseq(s,false);
    t:=Cputime();
    f:=FromDiseqToEq2(a,b);
    Append(~fs,f);
    t1+:=Cputime(t);
end for;
print "t1",t1;


for i in [1..n] do
    f:=Fpx.i^p-Fpx.i;
    Append(~fs,f);
end for;

t2:=Cputime();
I:=Ideal(fs);
V:=Variety(I);
print "t2", Cputime(t2);
V;
s;
*/


//task4


//task5
FromDiseqToLinEq:=function(a,b)
    Fp:=Parent(a[1]);
    p:=#Fp;
    f:=FromDiseqToEq(a,b);
    Fpx:=Parent(f);
    i:=p-1;
    seq:=[];
    repeat 
        for m in MonomialsOfDegree(Fpx,i) do
            seq:=Append(seq,MonomialCoefficient(f,m));
            m;
        end for;
        
    until i le 0;
    M:=Matrix([seq]);
    Cterm:=MonomialCoefficient(f,1);
    return M, Cterm,f;
end function;

/*
//test task5 b
p:=3;
n:=5;
num:=n^(p-1)-1;
ZN:=Integers(p);
s:=[Random(ZN) : i in [1..n]];

M:=ZeroMatrix(ZN,num,num);

for i in [1..num] do
    a,b:=RandomDiseq(s,false);
    coeffs, C,f:=FromDiseqToLinEq(a,b);
    NumberOfColumns(coeffs);
    num;
    f;
    for j in [1..num] do
        M[i,j]:=coeffs[1,j];
    end for;
end for;


Rank(M);
*/

KeyGen:=function(N,n) //KeyGen(N::RngIntElt, n::RngIntElt) -> ModMatRngElt, ModMatRngElt
    //TODO: change CN
    CN:=N-1;
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
    matx:=A*s;
    x:=<>;
    for i in [1..m] do
        Append(~x,matx[i,1]);
    end for;
    repeat
        flag:=true;
        Cup:=ZeroMatrix(ZN,n,m);
        for i in [1..n] do
            row:=RandomDiseq(x,true);
            for j in [1..m] do
                Cup[i,j]:=row[j];
            end for;
        end for;
        Ctrunc:=Submatrix(Cup,1,1,n,n);
        if not(IsUnit(Ctrunc)) then 
            flag:=false;
        end if;
    until flag;

    

    C:=ZeroMatrix(ZN,m,m);
    for i in [1..n] do
        for j in [1..m] do
            C[i,j]:=Cup[i,j];
        end for;
    end for;

    

    for i in [1..(m-n)] do
        row:=RandomDiseq(x,true);
        for j in [1..m] do
            C[i+n,j]:=row[j];
        end for;
    end for;
    
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
            //print "false 1", M, C;
            flag:=false;
        end if;
    else
        if c eq 1 then
            Mm:=M*resp;
            m:=NumberOfRows(M);
            for i in [1..m] do
                if Mm[i,1] eq 0 then 
                    //print "false 2", M, "resp",resp, "Mm",Mm;
                    flag:=false;
                end if;
            end for;
        end if;
    end if;
    return flag;
end function;

//task 7

FakeHash:=function(string) //FakeHash(string::MonStgElt) -> SeqEnum
    lamda:=127;
    p:=2^lamda-1;
    Fp:=FiniteField(p);
    Z:=Integers();
    h:=Fp ! 43;
    n:=#string;
    for i in [1..n] do 
        ascii:=StringToCode(string[i]);
        h:=h ^ (ascii+1) + 1;
    end for;
    return Intseq(Z ! h,2,lamda);
end function;

DiseqSign:=function(s, A, mess)
    lamda:=127;
    
    CiSeq:=[];
    MiSeq:=[];
    for i in [1..lamda] do
        Ci, Mi:=Commit(s, A);
        Append(~CiSeq,Ci);
        Append(~MiSeq,Mi);
    end for;
    ////
    print "step 1";
    AM:=Sprint(A);
    AM:= AM cat mess;
    for i in [1..lamda] do
        AM:=AM cat Sprint(MiSeq[i]);
    end for;
    c:=FakeHash(AM);

    print "step 2";
    sig:=<>;
    for i in [1..lamda] do
        Append(~sig, MiSeq[i]);
        respi:=Response(c[i], s, CiSeq[i]);
        Append(~sig, respi);
    end for;

    return sig;

end function;

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


/*
//test task7
s,A:=KeyGen(6, 30);
mess:="I will pay 10 EUR to Victor. Best wishes, Peggy";
t1:=Cputime();
sig:=DiseqSign(s, A, mess);
print Cputime(t1);
t2:=Cputime();
VerifySign(sig, A, mess);
print Cputime(t2);
print "s size", NumberOfRows(s);
print "A size", NumberOfRows(A), NumberOfColumns(A);
*/




//task 9
DiseqSignForge:=function(A,mess)
    lamda:=127;
    ZN:=Parent(A[1,1]);
    m:=NumberOfRows(A);
    n:=NumberOfColumns(A);

    CiSeq:=[];
    MiSeq:=[];
    miSeq:=[];
    for i in [1..lamda] do
        
            flag:=true;
            s:=RandomMatrix(ZN,n,1);
            matx:=A*s;
            x:=<>;
            for i in [1..m] do
                Append(~x,matx[i,1]);
            end for;

            repeat
                flagtrunc:=true;
                Cupi:=ZeroMatrix(ZN,n,m);
                for i in [1..n] do
                    row:=RandomDiseq(x,true);
                    for j in [1..m] do
                        Cupi[i,j]:=row[j];
                    end for;
                end for;
                Ctrunci:=Submatrix(Cupi,1,1,n,n);
                if not(IsUnit(Ctrunci)) then
                    flagtrunc:=false;
                end if;
            until flagtrunc;

            Ci:=ZeroMatrix(ZN,m,m);
            for i in [1..n] do
                for j in [1..m] do
                    Ci[i,j]:=Cupi[i,j];
                end for;
            end for;

            

            for i in [1..(m-n)] do
                row:=RandomDiseq(x,true);
                for j in [1..m] do
                    Ci[i+n,j]:=row[j];
                end for;
            end for;


            mi:=Ctrunci^-1 * s;
            Mi:=Ci*A*Ctrunci;
        
        
        Append(~CiSeq, Ci);
        Append(~MiSeq, Mi);
        Append(~miSeq, mi);
    end for;
    
    AM:=Sprint(A);
    AM:= AM cat mess;
    for i in [1..lamda] do
        AM:=AM cat Sprint(MiSeq[i]);
    end for;
    c:=FakeHash(AM);

    
    sig:=<>;
    for i in [1..lamda] do
        if c[i] eq 0 then
            Append(~sig, MiSeq[i]);
            Append(~sig, CiSeq[i]);
        else
            Append(~sig, MiSeq[i]);
            Append(~sig, miSeq[i]);
        end if;
    end for;

    return sig;
end function;

/*
//test task9
s,A:=KeyGen(6, 30);
mess:="I will pay 10000 EUR to Eve. Best wishes, Peggy";
sig:=DiseqSignForge(A, mess);
VerifySign(sig, A, mess);
*/

