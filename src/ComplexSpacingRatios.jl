module ComplexSpacingRatios

using NearestNeighbors

export complex_spacing_ratios

"""
complex_spacing_ratios(values::AbstractVector{T}) where T<:Complex

For every value λ in the input vector, this function calculates the
complex spacing ratio between the nearest (λ_n) and next nearest 
(λ_nn) level:

	(λ_n - λ)/(λ_nn - λ).

The distance is measured in terms of the Euclidean distance. The 
input vector is assumed to be a set of complex numbers.

"""
function complex_spacing_ratios end


function complex_spacing_ratios(values::AbstractVector{T}) where T<:Complex

	# convert in 2D real points
	data = reinterpret(reshape, real(eltype(values)), values)

	# distance tree by NearestNeighbors.jl
	tree = KDTree(data)
	n_idxs, _ = knn(tree, data, 3, true)

	rs = zeros(T, length(values))
	for i in eachindex(values, n_idxs)

		λ = values[i]  # λ == values[n_idxs[i][1]]
		λ_n = values[n_idxs[i][2]]
		λ_nn = values[n_idxs[i][3]]

		rs[i] = (λ_n - λ)/(λ_nn - λ)
	end
	rs
end


end