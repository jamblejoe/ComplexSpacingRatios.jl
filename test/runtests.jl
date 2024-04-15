using Test
using ComplexSpacingRatios

@testset "complex values" begin 
    eigenvalues = [1.0 + 1.0im, 2.0 + 2.0im, 4.0 + 4.0im,]
    rs = complex_spacing_ratios(eigenvalues)
    @test rs ≈ [1/3, -1/2, 2/3]
end


