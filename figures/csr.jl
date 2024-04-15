### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 5c4ac881-668f-4b66-a893-64301cbd184b
import Pkg; Pkg.activate(".")

# ╔═╡ 0d8ed55c-f786-11ee-04b5-d1910a851620
using Plots, LaTeXStrings

# ╔═╡ 3d501dc9-9d7e-493d-ae06-7b640eb38e2d
using LinearAlgebra, Random

# ╔═╡ b42a58d0-f870-4de7-af97-b1fe99a6ebda
using ProfileView

# ╔═╡ 6126c6eb-e3ee-43ca-9aed-26ed8c252b2b
using ComplexSpacingRatios

# ╔═╡ 2193ce3b-c0cb-40dc-b082-9eafb0e5a68f
N = 100

# ╔═╡ 1066e4a1-1682-46d2-91a0-bd410cb58c52
n = 1000

# ╔═╡ abb61239-55d0-48a9-9cf5-289a3d5ab08a
csr_RMT = let
	csr = Vector{Vector{ComplexF64}}(undef, n)
	Threads.@threads for i in 1:n
		A = randn(MersenneTwister(i),ComplexF64,N,N)
		csr[i] = complex_spacing_ratios(eigvals!(A))
	end
	collect(Iterators.flatten(csr))
end

# ╔═╡ 9884406b-cb90-463a-90c8-f04e55b306ef
csr_iid = complex_spacing_ratios(randn(MersenneTwister(1),ComplexF64,N*n))

# ╔═╡ 9aafebf2-f6f2-41e8-87ef-3a9cf5af7dc5
p = let
	pl1 = histogram2d(csr_RMT;
		bins=50,
		normalize=:pdf,
		#color=reverse(cgrad(:grays)),
		clims=(0,0.6),
		cbar=:none,
		title="random matrix",
		ylabel=L"\operatorname{Im}\ z",
	)
	
	pl2 = histogram2d(csr_iid;
		bins=50,
		normalize=:pdf,
		#color=reverse(cgrad(:grays)),
		clims=(0,0.6),
		title="independent",
		ylabel="",
		yticks=[],
	)
	plot(pl1,pl2;
		size=(600,300),
		layout=(@layout [a b{0.56w}]),
		aspectratio=1,
		lims=(-1.1,1.1),
		background_color_inside=:black,
		xlabel=L"\operatorname{Re}\ z",
		
	)
end

# ╔═╡ 590a8285-e783-48e9-a71b-938985a412ac
savefig(p, "csr.png")

# ╔═╡ Cell order:
# ╠═5c4ac881-668f-4b66-a893-64301cbd184b
# ╠═0d8ed55c-f786-11ee-04b5-d1910a851620
# ╠═3d501dc9-9d7e-493d-ae06-7b640eb38e2d
# ╠═b42a58d0-f870-4de7-af97-b1fe99a6ebda
# ╠═6126c6eb-e3ee-43ca-9aed-26ed8c252b2b
# ╠═2193ce3b-c0cb-40dc-b082-9eafb0e5a68f
# ╠═1066e4a1-1682-46d2-91a0-bd410cb58c52
# ╠═abb61239-55d0-48a9-9cf5-289a3d5ab08a
# ╠═9884406b-cb90-463a-90c8-f04e55b306ef
# ╠═9aafebf2-f6f2-41e8-87ef-3a9cf5af7dc5
# ╠═590a8285-e783-48e9-a71b-938985a412ac
