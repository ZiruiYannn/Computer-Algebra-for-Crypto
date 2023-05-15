//implement RSA

//key generate
RSAKeyGen:=function(b)
    len_p:=Random(b-4)+2;
    len_q:=b-len_p;
    p:=RandomPrime(len_p : Proof:=false);
    q:=RandomPrime(len_q : Proof:=false);

    N:=p*q;
    phi_N:=(p-1)*(q-1);
    
    Z:=Integers();
    Zphi:=Integers(phi_N);

    e:=N;
    while e ge phi_N do
        e:=RandomPrime(b : Proof:=false);
    end while;

    e_Rng:=Zphi ! e; 
    d_Rng:=e_Rng^-1;
    d:=Z ! d_Rng;

    return N, e, d;

end function;

// Encrypt a message

RSAEncrypt:=function(m, N, e)
    Z:=Integers();
    ZN:=Integers(N);

    c:=ZN ! m^e;
    c:=Z ! c;
    return c;
end function;

//Decrypt a ciphertext

RSADecrypt:=function(c, N, d)
    Z:=Integers();
    ZN:=Integers(N);

    m:=ZN ! c^d;
    m:=Z ! m;
    return m;
end function;

//CRT

RSAKeyGen_CRT:=function(b)
    len_p:=Random(b-4)+2;
    len_q:=b-len_p;
    p:=RandomPrime(len_p : Proof:=false);
    q:=RandomPrime(len_q : Proof:=false);

    N:=p*q;
    phi_N:=(p-1)*(q-1);
    
    Z:=Integers();
    Zphi:=Integers(phi_N);

    e:=N;
    while e ge phi_N do
        e:=RandomPrime(b : Proof:=false);
    end while;

    e_Rng:=Zphi ! e; 
    d_Rng:=e_Rng^-1;
    d:=Z ! d_Rng;

    return N, e, d, p, q;

end function;


RSADecrypt_CRT:=function(c, p, q , d)
    Z:=Integers();
    Zp:=Integers(p);
    Zq:=Integers(q);

    mod_p:=Zp ! c^d;
    mod_p:=Z ! mod_p;
    mod_q:=Zq ! c^d;
    mod_q:=Z ! mod_q;

    m:=CRT([mod_p, mod_q], [p, q]);
    return m;
end function;


    

