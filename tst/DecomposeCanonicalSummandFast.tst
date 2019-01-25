gap> # some random group
gap> G := DirectProduct(SymmetricGroup(3), SymmetricGroup(3));;
gap> irreps := IrreducibleRepresentations(G);;
gap> rho := DirectSumRepList([irreps[2], irreps[2], irreps[2]]);;
gap> # so the canonical summand is just the whole space
gap> summand := Cyclotomics^3;;
gap> # and each axis is an irreducible G-invariant space
gap> DecomposeCanonicalSummandFast@RepnDecomp(rho, irreps[2], summand); # should get 3 bits, 1 for each irrep
[ rec( basis := [ [ 1, 0, 0 ] ] ), rec( basis := [ [ 0, 1, 0 ] ] ), rec( basis := [ [ 0, 0, 1 ] ] ) ]
gap> # something more complicated
gap> rho := DirectSumRepList([irreps[1], irreps[2], irreps[2], irreps[3]]);;
gap> DecomposeCanonicalSummandFast@RepnDecomp(rho, irreps[2], VectorSpace(Cyclotomics, [[0,1,0,0],[0,0,1,0]]));
[ rec( basis := [ [ 0, 1, 0, 0 ] ] ), rec( basis := [ [ 0, 0, 1, 0 ] ] ) ]
gap> DecomposeCanonicalSummandFast@RepnDecomp(rho, irreps[3], VectorSpace(Cyclotomics, [[0,0,0,1]]));
[ rec( basis := [ [ 0, 0, 0, 1 ] ] ) ]