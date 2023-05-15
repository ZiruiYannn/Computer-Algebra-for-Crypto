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