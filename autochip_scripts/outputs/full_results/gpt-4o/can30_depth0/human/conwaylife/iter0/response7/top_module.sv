module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [15:0] grid [15:0];  // 16x16 grid

	integer i, j;

	// Helper function to count neighbors
	function integer count_neighbors;
		input [15:0] row [15:0];
		input integer x, y;
		integer count, ni, nj;
		begin
			count = 0;
			for (ni = -1; ni <= 1; ni = ni + 1) begin
				for (nj = -1; nj <= 1; nj = nj + 1) begin
					if (ni != 0 || nj != 0) begin
						count = count + row[(x + ni) & 4'hF][(y + nj) & 4'hF];
					end
				end
			end
			count_neighbors = count;
		end
	endfunction

	// Load initial state or update state
	always @(posedge clk) begin
		if (load) begin
			for (i = 0; i < 16; i = i + 1) begin
				grid[i] <= data[i*16 +: 16];
			end
		end else begin
			reg [15:0] new_grid [15:0];
			integer neighbors;
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					neighbors = count_neighbors(grid, i, j);
					case (neighbors)
						0, 1: new_grid[i][j] = 0;
						2:    new_grid[i][j] = grid[i][j];
						3:    new_grid[i][j] = 1;
						default: new_grid[i][j] = 0;
					endcase
				end
			end

			for (i = 0; i < 16; i = i + 1) begin
				grid[i] <= new_grid[i];
			end
		end

		// Update the output q with the grid state
		for (i = 0; i < 16; i = i + 1) begin
			q[i*16 +: 16] <= grid[i];
		end
	end
endmodule
