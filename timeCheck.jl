
function isStable(grid::Array{Float32,1}, odd_grid::Array{Float32,1}, nrow::UInt32, ncol::UInt32, epsilon::Float32)

	for i in 1:nrow-2, j in 2:ncol-1
		(abs(odd_grid[i*ncol + j] - grid[i*ncol + j]) > epsilon) && return false
	end
	return true
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
	nrow = read(STDIN, UInt32)
	ncol = read(STDIN, UInt32)
	epsilon = read(STDIN, Float32)
	its = read(STDIN, UInt32)

	grid = Array{Float32,1}(nrow, ncol)
	read!(STDIN, grid)

	odd_grid::Array{Float32,1} = copy(grid)

	even = true
	stable = false
	while !stable
		stabilize( (even) ? grid : odd_grid,  (even) ? odd_grid : grid, nrow, ncol)
		its += 1
		even = !even	
		stable = isStable(grid, odd_grid, nrow, ncol, epsilon)
	end
	its -= 1
	
	write(STDOUT, nrow)
	write(STDOUT, ncol)
	write(STDOUT, epsilon)
	write(STDOUT, its)
	write(STDOUT, (even) ? grid : odd_grid)
end
	

main()
