//load "D:/magma/Magma/repositories/Computer-Algebra-for-Crypto/assignment2/task3/task3.m";
//LatAttackDGHV(eta::RngIntElt,rho::RngIntElt, cs::SeqEnum(RngIntElt)) -> p::RngIntElt



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

/*
LatAttackDGHV:=function(eta, rho, cs)
    Z:=Integers();
    t:=#ci;
    alpha:=(2^rho);

    B:=ZeroMatrix(Z,t,t+1);
    for i in [1..t] do
        B[i,1]:=ci[i];
        B[i,i+1]:=alpha;
    end for;

    L:=LatticeWithBasis(B);

    LL:=LLL(L);
    U:=ZeroMatrix(Z,t,t);
    v0i:=[0 : i in [1..t]];
    print 1;
    for i in [1..t] do
        v0:=(LL.i)[1];
        v0i[i]:=v0;
        temp:=Coordinates(L, LL.i);
        for j in [1..t] do           
            U[i,j]:=temp[j];
        end for;
    end for;

    v0i:=Vector(v0i);
    ri:=v0i*(U^-1);

    pqi:=[ci[i]-ri[i] : i in [1..t]];

    pp:=Gcd(pqi);
    return pp;

end function;
*/

/*

LatAttackDGHV:=function(eta, rho, cs)
    Z:=Integers();
    t:=#cs;
    alpha:=Sqrt(t)/(t-1)/(Sqrt(t)+1)*(2^rho);

    B:=ZeroMatrix(Z,t,t+1);
    for i in [1..t] do
        B[i,1]:=Floor(cs[i]/alpha);
        B[i,i+1]:=1;
    end for;

    L:=LatticeWithBasis(B);
    //LLL BKZ
    LL:=LLL(L);
    U:=ZeroMatrix(Z,t,t);
    for i in [1..t] do
        temp:=Coordinates(L, LL.i);
        for j in [1..t] do           
            U[i,j]:=temp[j];
        end for;
    end for;

    inv_U:=U^-1;
    
    p1:=Abs(inv_U[1,t]);

    return Floor(cs[1]/p1);

end function;

*/