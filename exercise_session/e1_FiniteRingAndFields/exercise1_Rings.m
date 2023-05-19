//Construct the ring of integers Z and also the ring of integers modulo 105

Z:=Integers();
ZN:=Integers(105); //Set(ZN);

//Generate a couple of random elmts in ZN and ask for their inverse. What do you see?

a:=Random(ZN);
printf "a\n";
print a;
print a^-1;
/*
b:=Random(ZN);
printf "b\n";
print b;
print b^-1;
*/
//A:=Random(ZN,2);

//Use the built-in XGCD fcn. to compute the inverse via the greastest common divisor
a_int:=Z ! a;
x, y, z:=XGCD(a_int, 105);
printf "compute via gcd\n";
y:=ZN ! y;
y;

//compute inverse by Lagrange's thm. What is phi(N) in this case? What is the expression for the inverse as a power of the elmts? 
e:=EulerPhi(105);
printf "via EulerPhi";
print a^(e-1);



