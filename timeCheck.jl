
function isStable(grid::Array{Float32,1}, odd_grid::Array{Float32,1}, nrow::UInt32, ncol::UInt32, epsilon::Float32)

	for i in 1:nrow-2, j in 2:ncol-1
		(abs(odd_grid[i*ncol + j] - grid[i*ncol + j]) > epsilon) && return false
	end
	return true
end

function display(grid::Array{Float32,1}, nrow::UInt32, ncol::UInt32)

	for i in 0:nrow-1, j in 1:ncol
		print(grid[i*ncol + j], " ")
		(j == ncol) && println()
	end
end

function stabilize(grid::Array{Float32,1}, updated_grid::Array{Float32,1}, nrow::UInt32, ncol::UInt32)

		for i in 1:nrow-2, j in 2:ncol-1
			updated_grid[i*ncol + j] = (grid[(i - 1)*ncol + j] + 
						    grid[(i + 1)*ncol + j] + 
						    grid[i*ncol + j - 1] + 
						    grid[i*ncol +  j + 1]) / 4
		end
end

function main()
	nrow::UInt32 = 1024
	ncol::UInt32 = 1024
	epsilon::Float32 = 0.1
	its::UInt32 = 0

	grid::Array{Float32,1} = fill(0.0, nrow*ncol)
	for i in 1:nrow-2, j in 2:ncol-1
		grid[i*ncol + j] = 50.0
	end

	odd_grid::Array{Float32,1} = copy(grid)

	even = true
	stable = false
	while !stable
		stabilize( (even) ? grid : odd_grid,  (even) ? odd_grid : grid, nrow, ncol)
		its += 1
		even = !even	
		#display(grid, nrow, ncol)
		#display(updated_grid, nrow, ncol)
		stable = (abs(grid[ncol + 2] - odd_grid[ncol + 2]) < epsilon) && isStable(grid, odd_grid, nrow, ncol, epsilon)
	end
	its -= 1
	println(its)
end
	

main()
