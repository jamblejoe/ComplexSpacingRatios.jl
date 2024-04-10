module ComplexSpacingRatios

using NearestNeighbors

"""
ratios(eigenvalues::AbstractVector{T}) where T<:Number

Calculates the ratios of the distances between the 
nearest and next nearest level:

	(λ_nn - λ)/(λ_next_nn - λ).

"""
function ratios(eigenvalues::AbstractVector{T}) where T<:Number

    # convert in 2D real points
    data = reinterpret(reshape, real(eltype(eigenvalues)), eigenvalues)

	# distance tree by NearestNeighbors.jl
	tree = KDTree(data)
	n_idxs, _ = knn(tree, data, 3, true)

    rs = zeros(T, length(eigenvalues))
	for i in eachindex(eigenvalues, n_idxs)

		λ = eigenvalues[i]  # λ == eigenvalues[n_idxs[i][1]]
		λ_nn = eigenvalues[n_idxs[i][2]]
		λ_next_nn = eigenvalues[n_idxs[i][3]]

        rs[i] = (λ_nn - λ)/(λ_next_nn - λ)
	end
    rs
end


end