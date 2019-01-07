gap> G := SymmetricGroup(4);;
gap> gens := GeneratorsOfGroup(G);;
gap> irreps := IrreducibleRepresentations(G);;
gap> # note deg irrep1 = 1, deg irrep2 = 1, deg irrep3 = 2, deg irrep4 = 3
gap> imgs := List(gens, g -> BlockDiagonalMatrix([Image(irreps[2], g), Image(irreps[3], g), Image(irreps[4], g)]));;
gap> # we make rho = irrep2 oplus irrep3 oplus irrep4
gap> rho := GroupHomomorphismByImages(G, Group(imgs), gens, imgs);;
gap> # so the canonical decomposition should have 3 nonzero parts with correct dim
gap> List(CanonicalDecomposition(rho), Dimension);
[ 0, 1, 2, 3, 0 ]
gap> # now we do one which has repeat summands
gap> imgs := List(gens, g -> BlockDiagonalMatrix([Image(irreps[2], g), Image(irreps[2], g), Image(irreps[2], g)]));;
gap> rho := GroupHomomorphismByImages(G, Group(imgs), gens, imgs);;
gap> # so the canonical decomposition should have 1 nonzero part with correct dim
gap> List(CanonicalDecomposition(rho), Dimension);
[ 0, 3, 0, 0, 0 ]