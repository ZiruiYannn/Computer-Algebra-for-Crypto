

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


ZN:=Integers(5);
n:=3;
m:=7;
x:=<ZN!5,ZN!3,ZN!5,ZN!1,ZN!5,ZN!5,ZN!5>;
repeat
        flag:=true;
        Cup:=ZeroMatrix(ZN,n,m);
        for i in [1..n] do
            row:=RandomDiseq(x,true);
            print "row";
            row;
            for j in [1..m] do
                Cup[i,j]:=row[j];
            end for;
        end for;
        Ctrunc:=Submatrix(Cup,1,1,n,n);
        if not(IsUnit(Ctrunc)) then 
            flag:=false;
        end if;
until flag;

IsUnit(Ctrunc);