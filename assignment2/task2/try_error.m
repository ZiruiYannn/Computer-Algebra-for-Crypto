/*
RemoveProjectiveSummands:=function(M)
    if Type(M) ne ModGrp then
        error "Error in 'RemoveProjectiveSummands': Bad argument types";
    end if;
    G:=Group(M);
    error if(not(IsPrimePower(Order(G)))),
        "Error in 'RemoveProjectiveSummands': Group is not a p-group";
    Bool,p:=IsPrimePower(Order(G));
    K:=Field(M);
    error if Characteristic(K) ne p,
        "Error in 'RemoveProjectiveSummands': Characteristic does not match up with group";
    KG:=PermutationModule(G,sub<G|>,K);
    n:=0;
    repeat n+:=1;
        N:=sub<M|Random(M)>;
        if(IsIsomorphic(N,KG)) then
        M:=M/N;
        n:=0;
        end if;
        until n eq 20;
    return M;
end function;



G:=CyclicGroup(6);
H:=AbelianGroup(GrpPerm,[3,3]);
K:=GF(2);
F:=GF(3);
KG:=PermutationModule(G,sub<G|>,K);
KH:=PermutationModule(H,sub<H|>,K);
FH:=PermutationModule(H,sub<H|>,F);
M:=DirectSum(FH,TrivialModule(H,F));
RemoveProjectiveSummands(G);
*/
SetOutputFile("D:/magma/Magma/assignment2/task2/myoutput.txt");
print 111, 2222, "fefe";
UnsetOutputFile();
