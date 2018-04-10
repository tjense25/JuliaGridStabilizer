nrow = 1024
ncol = 1024
epsilon = 0.1
its = 0

grid = fill(0.0, nrow*ncol)
for i in 1:nrow-2, j in 2:ncol-1
	grid[i*ncol + j] = 50.0
end

updated_grid = fill(0.0, nrow*ncol)

function isStable(grid, updated_grid, nrow, ncol, epsilon)
	for j in 1:ncol-2, i in 2:nrow-1
		(abs(updated_grid[i*ncol + j] - grid[i*ncol + j]) > epsilon) && return false
	end
	return true
end

function display(grid::Array{Float64,1}, nrow, ncol)
	for i in 0:nrow-1, j in 1:ncol
		print(grid[i*ncol + j], " ")
		(j == ncol) && println()
	end
end

while !isStable(grid, updated_grid, nrow, ncol, epsilon)
	for i in 1:nrow-2, j in 2:ncol-1
		updated_grid[i*ncol + j] = (grid[(i - 1)*ncol + j] + 
					    grid[(i + 1)*ncol + j] + 
					    grid[i*ncol + j - 1] + 
					    grid[i*ncol +  j + 1]) / 4
	end
	temp = grid
	grid = updated_grid
	updated_grid = temp
	its += 1
	display(grid, nrow, ncol)
end
its -= 1
println(its)

