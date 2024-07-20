module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// A function to get the state of a cell at (x, y), taking into account the toroidal wrap-around
	function [0:0] get_cell;
		input [255:0] grid;
		input [3:0] x;
		input [3:0] y;
		begin
			get_cell = grid[{x, y}];
		end
	endfunction

	// A function to count the number of alive neighbors for a cell at (x, y)
	function [3:0] count_neighbors;
		input [255:0] grid;
		input [3:0] x;
		input [3:0] y;
		reg [3:0] count;
		integer dx, dy;
		begin
			count = 0;
			for (dx = -1; dx <= 1; dx = dx + 1) begin
				for (dy = -1; dy <= 1; dy = dy + 1) begin
					if (dx != 0 || dy != 0) begin
						count = count + get_cell(grid, (x + dx) & 4'hf, (y + dy) & 4'hf);
					end
				end
			end
			count_neighbors = count;
		end
	endfunction

	// Update the grid based on the game rules
	function [255:0] update_grid;
		input [255:0] grid;
		integer x, y;
		reg [3:0] count;
		begin
			for (x = 0; x < 16; x = x + 1) begin
				for (y = 0; y < 16; y = y + 1) begin
					count = count_neighbors(grid, x, y);
					if (count < 2 || count > 3)
						update_grid[{x, y}] = 1'b0;
					else if (count == 3)
						update_grid[{x, y}] = 1'b1;
					else
						update_grid[{x, y}] = get_cell(grid, x, y);
				end
			end
		end
	endfunction

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= update_grid(q);
	end
endmodule
