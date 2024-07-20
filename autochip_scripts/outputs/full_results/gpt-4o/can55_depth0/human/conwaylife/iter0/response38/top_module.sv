module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	// Helper function: Counts the number of live neighbors for a given cell
	function [3:0] count_neighbors;
		input [15:0][15:0] grid;
		input [3:0] x, y;
		integer i, j;
		begin
			count_neighbors = 0;
			for (i = -1; i <= 1; i = i + 1) begin
				for (j = -1; j <= 1; j = j + 1) begin
					if (!(i == 0 && j == 0)) begin
						count_neighbors = count_neighbors + grid[(x + i + 16) % 16][(y + j + 16) % 16];
					end
				end
			end
		end
	endfunction
	
	// 2D grid representation
	reg [15:0][15:0] grid;
	reg [15:0][15:0] next_grid;
	integer x, y;

	// Initial state
	always @(posedge clk) begin
		if (load) begin
			for (x = 0; x < 16; x = x + 1) begin
				for (y = 0; y < 16; y = y + 1) begin
					grid[x][y] <= data[x*16 + y];
				end
			end
		end else begin
			for (x = 0; x < 16; x = x + 1) begin
				for (y = 0; y < 16; y = y + 1) begin
					case (count_neighbors(grid, x, y))
						4'd0, 4'd1: next_grid[x][y] <= 0;
						4'd2: next_grid[x][y] <= grid[x][y];
						4'd3: next_grid[x][y] <= 1;
						default: next_grid[x][y] <= 0;
					endcase
				end
			end
			grid <= next_grid;
		end
	end

	// Generating the output
	always @* begin
		for (x = 0; x < 16; x = x + 1) begin
			for (y = 0; y < 16; y = y + 1) begin
				q[x*16 + y] = grid[x][y];
			end
		end
	end

endmodule
