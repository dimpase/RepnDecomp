#! @BeginChunk Example_LinearRepresentationIsomorphism
#! @BeginExample
G := SymmetricGroup(4);;
irreps := IrreducibleRepresentations(G);;
# rho and tau are isomorphic - they just have a different block order
rho := DirectSumOfRepresentations([irreps[1], irreps[3], irreps[3]]);;
tau := DirectSumOfRepresentations([irreps[3], irreps[1], irreps[3]]);;
# tau2 is just tau with a basis change - still isomorphic
B := RandomInvertibleMat(5);;
tau2 := ComposeHomFunction(tau, x -> B^-1 * x * B);;
# using the default implementation
M := LinearRepresentationIsomorphism(rho, tau);;
IsLinearRepresentationIsomorphism(M, rho, tau);
#! true
M := LinearRepresentationIsomorphism(tau, tau2);;
IsLinearRepresentationIsomorphism(M, tau, tau2);
#! true
# using the kronecker sum implementation
M := LinearRepresentationIsomorphism(tau, tau2 : use_kronecker);;
IsLinearRepresentationIsomorphism(M, tau, tau2);
#! true
# using the orbit sum implementation
M := LinearRepresentationIsomorphism(tau, tau2 : use_orbit_sum);;
IsLinearRepresentationIsomorphism(M, tau, tau2);
#! true
# two distinct irreps are not isomorphic
M := LinearRepresentationIsomorphism(irreps[1], irreps[2]);
#! fail
#! @EndExample
#! @EndChunk

#! @BeginChunk Example_LinearRepresentationIsomorphismSlow
#! @BeginExample
# following on from the previous example
M := LinearRepresentationIsomorphismSlow(rho, tau);;
IsLinearRepresentationIsomorphism(M, rho, tau);
#! true
#! @EndExample
#! @EndChunk
