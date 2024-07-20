module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// 16x16 grid
	reg [15:0] grid [15:0];

	integer i, j;

	// Torch the grid when load is high
	always @(posedge clk) begin
		if (load) begin
			for (i = 0; i < 16; i = i + 1) begin
				grid[i] <= data[i*16 +: 16];
			end
		end else begin
			reg [15:0] new_grid [15:0];
			// Calculate the next state of the grid
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					integer neighbors;
					neighbors = 0;
					// Check the 8 neighbors, using modulo to handle wrapping
					neighbors = grid[(i-1+16)%16][(j-1+16)%16] +
								grid[(i-1+16)%16][j] +
								grid[(i-1+16)%16][(j+1)%16] +
								grid[i][(j-1+16)%16] +
								grid[i][(j+1)%16] +
								grid[(i+1)%16][(j-1+16)%16] +
								grid[(i+1)%16][j] +
								grid[(i+1)%16][(j+1)%16];
					// Apply the rules of the game
					if (neighbors < 2 || neighbors > 3)
						new_grid[i][j] = 0;
					else if (neighbors == 3)
						new_grid[i][j] = 1;
					else
						new_grid[i][j] = grid[i][j];
				end
			end
			// Update the grid for the next state
			for (i = 0; i < 16; i = i + 1) begin
				grid[i] <= new_grid[i];
			end
		end
	end

	// Flatten the 2D grid to 1D output
	always @(*) begin
		for (i = 0; i < 16; i = i + 1) begin
			q[i*16 +: 16] = grid[i];
		end
	end
	
endmodule
