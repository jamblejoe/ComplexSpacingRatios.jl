# ComplexSpacingRatios.jl

This package provides the single function `ratios` to compute the spacing ratios of (complex random) values $(\lambda_1,\lambda_2,\dots)$. The spacing ratio $z$ is defined as
$$
    z = \frac{\lambda^{(N)}-\lambda}{\lambda^{(NN)}-\lambda},
$$
where $\lambda^{(N)}$ is the closest neighbor of $\lambda$ in Euclidean distance and $\lambda^{(NN)}$ is the second closest neighbor. The ratio distribution is confined to the unit circle, $|z|\le1$.

The spacing ratio is a useful quantity to study correlations of random variables. For independent and identically distributed random variables the ratio distribution $z$ is uniform in the unit disk. For correlated random variables, like the eigenvalues of random matrices, the ratio distribution $z$ is not flat, but typically features vanishing density around $z=0$ and $z=1$ for random matrices.

![spacing ratios of eigenvalues of random matrices and independent values](/plots/csr.png)

The spacing ratios of (non-Hermitian) matrix eigenvalues
```julia
using LinearAlgebra

A = randn(ComplexF64, 100, 100)
eigenvalues = eigvals(A)
```
can be computed with the function `ratios` as follows:
```julia
using ComplexSpacingRatios

ratios(eigenvalues)
```
