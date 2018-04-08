
nrow = 1024
ncol = 1024
epsilon = 0.1
its = 0

grid = [(i==1||i==nrow||j==1||j==ncol) ? 0.0 : 50.0 for j in 1:ncol, i in 1:nrow]
updated_grid = fill(0.0, (nrow,ncol))

function isStable(grid, updated_grid, nrow, ncol, epsilon)
	for j in 2:(ncol - 1), i in 2:(nrow - 1)
		(abs(updated_grid[i,j] - grid[i,j]) > epsilon) && return false
	end
	return true
end

function stabilize(grid, updated_grid, nrow, ncol)
	for j in 2:(ncol - 1), i in 2:(nrow - 1)
		updated_grid[i,j] = (grid[i - 1, j] + grid[i + 1, j] + grid[i, j - 1] + grid[i, j + 1]) / 4.0
	end
	updated_grid
end

while !isStable(grid, updated_grid, nrow, ncol, epsilon)
	updated_grid = stabilize(grid, updated_grid, nrow, ncol)
	grid, updated_grid = updated_grid, grid
	its += 1
end
its -= 1
println(its)
